import 'package:flutter/material.dart';
import 'package:open_wheels/data/preferences.dart';

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //Inicialización de las preferencias para mostrar elementos dinámicos

    return BottomNavigationBar(items: [
      UserPreferences.autoLogin
          ? const BottomNavigationBarItem(label: 'home',
              icon: Icon(Icons.home),
            )
          : const BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'home'),
      const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'home')
    ]);
  }
}
