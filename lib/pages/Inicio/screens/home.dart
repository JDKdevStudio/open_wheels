import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/pages/Inicio/widgets/widgets.dart';
import 'package:open_wheels/pages/screens.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
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
      bottomNavigationBar:
          CustomNavigator(userData: userData, pageNavigator: _pageNavigator),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageNavigator,
        children: [
          const InicioPage(),
          const _AssistantPage(),
          const RoutesPage(),
          const VehiclesPage(),
          if (userData.userData.role == 'admin') const AdminPage(),
        ],
      ),
    );
  }
}

class _AssistantPage extends StatelessWidget {
  const _AssistantPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backendProvider = Provider.of<BackendProvider>(context);
    final formProvider = Provider.of<FormProvider>(context, listen: false);
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

        FutureBuilder<List<Routes>>(
          future: backendProvider.getUserRoutes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final routesData = snapshot.data!;
              backendProvider.getUserCars();
              return routesData.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_outlined,
                              size: size.width * 0.3, color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'No hay rutas en el sistema',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount: routesData.length,
                        itemBuilder: (_, index) {
                          final item = routesData[index];
                          return GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                        'Inscrito en Ruta Satisfactoriamente'),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                    ),
                                    backgroundColor: Colors.white,
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cerrar'),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: CardInfo(item: item));
                        },
                      ),
                    );
            }
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff1C2321),
                ),
              ),
            );
          },
        )
      ],
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
    return CustomDrawerNavigator(userData: userData, options: options);
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
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
                  'Panel Principal',
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
        IconButton(
            onPressed: () => Navigator.pushNamed(context, 'register_route'),
            icon: const Icon(Icons.abc))
      ],
    );
  }
}
