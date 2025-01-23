import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/routes/route_factory.dart';
import 'package:ecos_main/Screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: Routes.splashScreen,
  routes: [
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.splashScreen,
      builder: (ctx, state) => const SplashScreen(),
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.home,
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.login,
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.register,
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.forgotPassword,
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.changePassword,
    ),
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.todo,
      name: 'Todo',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.expenses,
      name: 'Todo',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.fTracker,
      name: 'Todo',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
  ],
);
