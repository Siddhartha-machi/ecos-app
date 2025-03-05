import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomNavItems;
  final StatefulNavigationShell navigationShell;

  const ShellScreen({
    required this.bottomNavItems,
    required this.navigationShell,
    super.key,
  });

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
        items: bottomNavItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
