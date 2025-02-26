import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/routes/route_factory.dart';
import 'package:ecos_main/Screens/splash_screen.dart';
import 'package:ecos_main/Screens/auth/auth_screen.dart';

final router = GoRouter(
  initialLocation: Routes.splashScreen,
  routes: [
    // Authentication routes
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.splashScreen,
      name: 'Splash',
      builder: (ctx, state) => const SplashScreen(),
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.login,
      name: 'Login',
      builder: (ctx, state) => AuthScreen(state),
    ),
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.auth.register,
      name: 'Register',
      builder: (ctx, state) => AuthScreen(state),
    ),
    CustomRouteFactory.staticRouteBuilder(
      name: 'Personal Details',
      path: Routes.auth.personalDetails,
      builder: (ctx, state) => AuthScreen(state),
    ),
    CustomRouteFactory.staticRouteBuilder(
      name: 'forgot-password',
      path: Routes.auth.forgotPassword,
    ),
    CustomRouteFactory.staticRouteBuilder(
      name: 'change-password',
      path: Routes.auth.changePassword,
    ),

    // Manager routes
    CustomRouteFactory.staticRouteBuilder(
      path: Routes.home,
      name: 'Home',
    ),

    // Extension routes
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.todo,
      name: 'Todo',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.expenses,
      name: 'Expense',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
    CustomRouteFactory.nestedRouteBuilder(
      basePath: Routes.extension.fTracker,
      name: 'Tracker',
      rootBuilder: (id, state) => const Placeholder(),
      detailBuilder: (id, state) => const Placeholder(),
      updateBuilder: (id, state) => const Placeholder(),
    ),
  ],
);
