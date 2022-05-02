import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/providers/providers.dart';

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({
    Key? key,
    required this.userData,
    required PageController pageNavigator,
  }) : _pageNavigator = pageNavigator, super(key: key);

  final BackendProvider userData;
  final PageController _pageNavigator;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
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
    );
  }
}