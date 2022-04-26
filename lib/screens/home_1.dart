import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/providers/backend_provider.dart';
import 'package:open_wheels/providers/navigator_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context);
    final _pageNavigator = PageController(
        initialPage: navigatorProvider.navigationIndex, keepPage: true);
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
          index: navigatorProvider.navigationIndex,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          items: const [
            Icon(Icons.person_pin_circle_outlined, size: 30),
            Icon(Icons.map_outlined, size: 30),
            Icon(Icons.alt_route_outlined, size: 30),
            Icon(Icons.directions_car_outlined, size: 30),
          ],
          onTap: (index) {
            navigatorProvider.navigationIndex = index;
            _pageNavigator.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
        ),
      ),
      body: PageView(
        controller: _pageNavigator,
        children: [
          _HomePage(),
          _HomePage(),
          Center(
            child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'register_route'),
                child: Text('PRUEBAS')),
          )
        ],
        onPageChanged: (index) {
          navigatorProvider.navigationIndex = index;
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
                  return ListTile(
                    title: Text(
                      options.keys.toList()[index],
                      style: const TextStyle(
                        color: Color(0xff202725),
                      ),
                    ),
                    leading: options.values.toList()[index],
                    onTap: () {},
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
            children: [
              const Text('Hola'),
            ],
          ),
        )
      ],
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
