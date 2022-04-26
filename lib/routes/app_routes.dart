import 'package:flutter/material.dart';
import 'package:open_wheels/providers/navigator_provider.dart';
import 'package:open_wheels/screens/screens.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    'warnings': (_) => const WarningsScreen(),
    'lobby': (_) => const LobbyScreen(),
    'login': (_) => const LoginScreen(),
    'register': (_) => const RegisterScreen(),
    'password': (_) => const ResetPasswordScreen(),
    'home': (_) => ChangeNotifierProvider(
          create: (_) => NavigatorProvider(),
          child: HomeScreen(),
        ),
    'register_route': (_) => const RegisterRouteScreen(),
  };
}
