import 'package:ecos_main/shared/lib/presentation/widgets/atoms/contained_button.dart';
import 'package:ecos_main/shared/lib/models/route_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final GoRouterState routeState;
  @override
  Widget build(BuildContext context) {
    print(Paths.extension.todo.root.absolutePath);
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
          child: Column(
        children: [
          ContainedButton(
              onPressed: () {
                GoRouter.of(context).go(Paths.extension.todo.root.absolutePath);
              },
              label: 'Go to Extensions'),
          const Text("Welcome to Ecos Home!"),
          // Text(routeState.fullPath ?? 'No path found'),
        ],
      )),
    );
  }
}
