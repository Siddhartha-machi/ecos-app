import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/screens/empty_route.dart';
import 'package:ecos_main/Screens/wrappers/shell_screen.dart';

class CustomRouteFactory {
  /// Default fallback screen when no route is found
  static Widget _fallbackBuilder(BuildContext ctx, GoRouterState state) {
    debugPrint('Fallback triggered for path: ${state.uri.toString()}');
    return EmptyRoute(state.uri.toString());
  }

  /// Default redirect (returns `null` for no redirection)
  static String? _defaultRedirect(BuildContext ctx, GoRouterState state) {
    debugPrint('Checking redirect for: ${state.uri.toString()}');
    return null;
  }

  /// Helper function to build routes requiring an ID
  static GoRoute parameterizedRoute({
    required String path,
    required Widget Function(String, GoRouterState) builder,
    String? Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRoute(
      path: path,
      redirect: redirect,
      builder: (context, state) {
        final String? id = state.pathParameters['id'];
        if (id == null || id.isEmpty) {
          debugPrint('Invalid or missing ID for route: $path');
          return _fallbackBuilder(context, state);
        }
        return builder(id, state);
      },
    );
  }

  /// Creates a simple route
  static GoRoute simpleRoute({
    required String path,
    Widget Function(BuildContext, GoRouterState)? builder,
    String? Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRoute(
      path: path,
      redirect: redirect ?? _defaultRedirect,
      builder: builder ?? _fallbackBuilder,
    );
  }

  /// Creates a stateful route with bottom navigation bar
  static RouteBase statefulRouteBuilder({
    required String root,
    required List<RouteBase> nestedRoutes,
    Widget Function(BuildContext, GoRouterState, StatefulNavigationShell)?
        builder,
  }) {
    return StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) => ShellScreen(navigationShell),
      branches: nestedRoutes
          .map((route) => StatefulShellBranch(routes: [route]))
          .toList(),
    );
  }

  /// Creates a grouped route
  static RouteBase groupedRoutes({
    required String root,
    Widget Function(BuildContext, GoRouterState)? rootBuilder,
    required List<RouteBase> nestedRoutes,
  }) {
    return GoRoute(
      path: root,
      builder: rootBuilder,
      routes: nestedRoutes,
    );
  }

  /// Error route to handle unknown paths
  static GoRoute errorRoute({
    required String path,
    Widget Function(BuildContext, GoRouterState)? builder,
  }) =>
      GoRoute(
        path: path,
        builder: builder ?? _fallbackBuilder,
      );
}
