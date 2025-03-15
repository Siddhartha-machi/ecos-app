import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScreen(this.navigationShell, {super.key});

  static const _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_sharp),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.extension_sharp),
      label: 'Extensions',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.workspaces_sharp),
      label: 'Your space',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_sharp),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_sharp),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: _bottomNavItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
