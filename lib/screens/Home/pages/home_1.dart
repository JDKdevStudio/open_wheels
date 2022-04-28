import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _pageNavigator = PageController(initialPage: 0, keepPage: true);
    final userData = Provider.of<BackendProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldkey,
      endDrawer: const _DrawerProfile(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1C2321),
        actions: [
          IconButton(
            onPressed: () => _scaffoldkey.currentState!.openEndDrawer(),
            icon: const Icon(Icons.person_outline_outlined),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 50,
            offset: Offset(0, -10),
          ),
        ]),
        child: CurvedNavigationBar(
          index: 0,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          items: [
            const Icon(Icons.person_pin_circle_outlined, size: 30),
            const Icon(Icons.map_outlined, size: 30),
            const Icon(Icons.alt_route_outlined, size: 30),
            const Icon(Icons.directions_car_outlined, size: 30),
            if (userData.userData.role == 'admin')
              const Icon(Icons.admin_panel_settings_outlined),
          ],
          onTap: (index) {
            _pageNavigator.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageNavigator,
        children: [
          const _HomePage(),
          _AssistantPage(),
          _RouteCreatorPage(),
          const _DriverPage(),
          if (userData.userData.role == 'admin') const _AdminPage(),
        ],
      ),
    );
  }
}

class _RouteCreatorPage extends StatelessWidget {
  const _RouteCreatorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class _AssistantPage extends StatelessWidget {
  const _AssistantPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        //*Header---------------------------------------------------------------
        Container(
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Asistente de Ruta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          width: double.infinity,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
            color: Color(0xff1C2321),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}

class _DriverPage extends StatelessWidget {
  const _DriverPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewUserCarsProvider = Provider.of<BackendProvider>(context);
    return Column(
      children: [
        //*Header---------------------------------------------------------------
        Container(
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Mis Vehículos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          width: double.infinity,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
            color: Color(0xff1C2321),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),

        //*ListBuilder----------------------------------------------------------
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if ((snapshot.data as List<Car>).isNotEmpty) {
                return _ViewCarsBuilder(
                    viewUserCarsProvider: viewUserCarsProvider,
                    userCars: snapshot.data as List<Car>);
              } else {
                return Expanded(
                    child: Center(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No tienes carros registrados'),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff1C2321)),
                        onPressed: () {
                          final resetRegister =
                              Provider.of<FormProvider>(context, listen: false);
                          resetRegister.resetPicker();
                          Navigator.pushNamed(context, 'register_car');
                        },
                        child: const Text('Registrar Vehículo'))
                  ],
                )));
              }
            }
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          },
          future: viewUserCarsProvider.getuserCars(),
        )
      ],
    );
  }
}

class _ViewCarsBuilder extends StatelessWidget {
  const _ViewCarsBuilder({
    Key? key,
    required this.userCars,
    required this.viewUserCarsProvider,
  }) : super(key: key);

  final List<Car> userCars;
  final BackendProvider viewUserCarsProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: userCars.length,
        itemBuilder: (BuildContext context, int index) {
          final item = userCars[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffFAFDFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(item.photo!),
                      radius: 35,
                    ),
                    Column(
                      children: [
                        Text(item.modelo!),
                        Text(item.placa!),
                      ],
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      onTap: () => Navigator.pushNamed(context, 'car_info',
                          arguments: item),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DrawerProfile extends StatelessWidget {
  const _DrawerProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = {
      'Mi perfil': const Icon(Icons.info_outline, color: Colors.black),
      'Configuración': const Icon(Icons.settings_outlined, color: Colors.black),
      'Cerrar Sesión':
          const Icon(Icons.exit_to_app_outlined, color: Colors.black)
    };
    final userData = Provider.of<BackendProvider>(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 60,
                    backgroundImage: NetworkImage(userData.userData.avatar!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    userData.userData.email!,
                    style: const TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Color(0XFF1C2321),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior1(),
              child: ListView.separated(
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final optionTitle = options.keys.toList()[index];
                  return ListTile(
                    title: Text(
                      optionTitle,
                      style: const TextStyle(
                        color: Color(0xff202725),
                      ),
                    ),
                    leading: options.values.toList()[index],
                    onTap: () {
                      switch (optionTitle) {
                        case 'Mi perfil':
                          Navigator.pushNamed(context, 'profile',
                              arguments: userData.userData);
                          break;
                        case 'Configuración':
                          break;
                        case 'Cerrar Sesión':
                          break;
                        default:
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 300, color: Colors.red),
        Expanded(
          child: Stack(
            children: const [
              Text('Hola'),
            ],
          ),
        )
      ],
    );
  }
}

class _AdminPage extends StatelessWidget {
  const _AdminPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pendingUsersProvider = Provider.of<BackendProvider>(context);
    return Column(
      children: [
        //*Header---------------------------------------------------------------
        Container(
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Solicitudes Pendientes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          width: double.infinity,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
            color: Color(0xff1C2321),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),

        //*ListBuilder----------------------------------------------------------
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if ((snapshot.data as List<UserData>).isNotEmpty) {
                return _PendingUsersBuilder(
                    pendingUsersProvider: pendingUsersProvider,
                    pendingUsers: snapshot.data as List<UserData>);
              } else {
                return const Expanded(
                    child:
                        Center(child: Text('No hay más usuarios por aprobar')));
              }
            }
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          },
          future: pendingUsersProvider.getPendingUsers(),
        )
      ],
    );
  }
}

class _PendingUsersBuilder extends StatelessWidget {
  const _PendingUsersBuilder({
    Key? key,
    required this.pendingUsers,
    required this.pendingUsersProvider,
  }) : super(key: key);

  final List<UserData> pendingUsers;
  final BackendProvider pendingUsersProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: pendingUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final item = pendingUsers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffFAFDFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Dismissible(
                key: Key(item.email!),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(item.avatar!),
                        radius: 35,
                      ),
                      Column(
                        children: [
                          Text(item.name!),
                          Text(item.email!),
                        ],
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.info_outline,
                          size: 35,
                        ),
                        onTap: () => Navigator.pushNamed(context, 'profile',
                            arguments: item),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red[900],
                      size: 35,
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green[900],
                      size: 35,
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                  } else {
                    pendingUsersProvider.aproveUser(context, item.objectId!);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyBehavior1 extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
