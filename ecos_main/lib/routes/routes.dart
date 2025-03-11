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
      rootBuilder: (ctx, state) => const SplashScreen(),
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
    CustomRouteFactory.statefulRouteBuilder(
      root: Paths.main.root.path,
      nestedRoutes: [
        CustomRouteFactory.simpleRoute(
          path: Paths.main.root.path,
          builder: (context, state) => const HomeScreen(),
        ),
        // Extension info Routes
        CustomRouteFactory.groupedRoutes(
          root: Paths.main.extensionList.path,
          rootBuilder: (context, state) => const ExtensionListingScreen(),
          nestedRoutes: [
            CustomRouteFactory.simpleRoute(
              path: Paths.main.extensionDetail.path,
              builder: (context, state) => ExtensionDetailScreen(state),
            ),
          ],
        ),

        CustomRouteFactory.groupedRoutes(
          root: Paths.extension.root.path,
          rootBuilder: (context, state) => const Placeholder(
            child: Text('Your space root'),
          ),
          nestedRoutes: [
            /// Todo Extension
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.todo.root.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.todo.stats.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.todo.settings.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.todo.detail.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.todo.update.path,
              builder: (context, state) => const Placeholder(),
            ),

            /// ETracker Extension
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.eTracker.root.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.eTracker.stats.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.eTracker.settings.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.eTracker.detail.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.eTracker.update.path,
              builder: (context, state) => const Placeholder(),
            ),

            /// Todo Extension
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.fTracker.root.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.fTracker.stats.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.simpleRoute(
              path: Paths.extension.fTracker.settings.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.fTracker.detail.path,
              builder: (context, state) => const Placeholder(),
            ),
            CustomRouteFactory.parameterizedRoute(
              path: Paths.extension.fTracker.update.path,
              builder: (context, state) => const Placeholder(),
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
