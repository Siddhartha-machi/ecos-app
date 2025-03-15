import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder(this.routeState, {super.key});

  final GoRouterState routeState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Path : ${routeState.path ?? 'No path found'}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
