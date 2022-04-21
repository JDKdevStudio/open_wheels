import 'package:flutter/material.dart';
import 'package:open_wheels/screens/screens.dart';

class AppRputes {
  static Map<String, Widget Function(BuildContext)> routes = {
    'warnings': (_) => const WarningsScreen(),
    'lobby': (_) => const LobbyScreen(),
    'login': (_) => const LoginScreen(),
    'register': (_) => const RegisterScreen(),
    'password': (_) => const ResetPasswordScreen(),
    'home': (_) => const HomeScreen(),
  };
}
