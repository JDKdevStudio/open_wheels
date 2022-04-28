import 'package:flutter/material.dart';
import 'package:open_wheels/screens/screens.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    'geocode': (_) => const AllowGeocodeScreen(),
    'warnings': (_) => const WarningsScreen(),
    'lobby': (_) => const LobbyScreen(),
    'login': (_) => const LoginScreen(),
    'register': (_) => const RegisterScreen(),
    'password': (_) => const ResetPasswordScreen(),
    'home': (_) => HomeScreen(),
    'profile': (_) => const UserProfileScreen(),
    'register_route': (_) => const RegisterRouteScreen(),
    'register_car': (_) => const RegisterCarScreen(),
     'car_info': (_) => const CarInfoScreen(),
  };
}
