import 'package:flutter/material.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';

class CustomDrawerNavigator extends StatelessWidget {
  const CustomDrawerNavigator({
    Key? key,
    required this.userData,
    required this.options,
  }) : super(key: key);

  final BackendProvider userData;
  final Map<String, Icon> options;

  @override
  Widget build(BuildContext context) {
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
              behavior: MyBehavior(),
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