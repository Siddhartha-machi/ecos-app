import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/routes/route_factory.dart';
import 'package:ecos_main/Screens/splash_screen.dart';
import 'package:ecos_main/Screens/auth/auth_screen.dart';
import 'package:ecos_main/Screens/home_screen.dart';
import 'package:ecos_main/Screens/extension_info_screen.dart';
import 'package:ecos_main/Screens/extension_listing_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Paths.auth.root.path,
  debugLogDiagnostics: true, // Enables debug logs for routing
  routes: [
    // Authentication Routes
    CustomRouteFactory.groupedRoutes(
      root: Paths.auth.root.path,
      builder: (ctx, state, _) => const SplashScreen(),
      nestedRoutes: [
        CustomRouteFactory.simpleRoute(
          path: Paths.auth.login.path,
          builder: (ctx, state) => AuthScreen(state),
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.auth.register.path,
          builder: (ctx, state) => AuthScreen(state),
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.auth.personalDetails.path,
          builder: (ctx, state) => AuthScreen(state),
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.auth.changePassword.path,
          builder: (ctx, state) => AuthScreen(state),
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.auth.forgotPassword.path,
          builder: (ctx, state) => AuthScreen(state),
        ),
      ],
    ),

    // Main routes
    CustomRouteFactory.groupedRoutes(
      root: Paths.main.root.path,
      enableState: true,
      bottomNavItems: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_sharp),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.extension_sharp),
          label: 'Extensions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_sharp),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_sharp),
          label: 'Settings',
        ),
      ],
      nestedRoutes: [
        CustomRouteFactory.simpleRoute(
          path: Paths.main.root.path,
          builder: (context, state) => const HomeScreen(),
        ),
        // Extension Routes
        CustomRouteFactory.groupedRoutes(
          root: Paths.extension.root.path,
          builder: (context, state, _) => const ExtensionListingScreen(),
          nestedRoutes: [
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.extensionInfo.path,
              builder: (context, state) => ExtensionDetailScreen(state),
            ),
            CustomRouteFactory.nestedRouteBuilder(
              pathConfig: Paths.extension.todo,
              rootBuilder: (context, state) => const Placeholder(),
              detailBuilder: (id, state) => const Placeholder(),
              updateBuilder: (id, state) => const Placeholder(),
            ),
            CustomRouteFactory.nestedRouteBuilder(
              pathConfig: Paths.extension.fTracker,
              rootBuilder: (context, state) => const Placeholder(),
              detailBuilder: (id, state) => const Placeholder(),
              updateBuilder: (id, state) => const Placeholder(),
            ),
            CustomRouteFactory.nestedRouteBuilder(
              pathConfig: Paths.extension.eTracker,
              rootBuilder: (context, state) => const Placeholder(),
              detailBuilder: (id, state) => const Placeholder(),
              updateBuilder: (id, state) => const Placeholder(),
            ),
          ],
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.main.profile.path,
          builder: (context, state) => const Placeholder(),
        ),
        CustomRouteFactory.simpleRoute(
          path: Paths.main.settings.path,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    ),

    // Error Route
    CustomRouteFactory.errorRoute(
      path: '/error',
      builder: (ctx, state) => Scaffold(
        body: Center(child: Text("Page not found: ${state.uri}")),
      ),
    ),
  ],
);
