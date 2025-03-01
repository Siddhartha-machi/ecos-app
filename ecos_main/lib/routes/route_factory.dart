import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/screens/empty_route.dart';
import 'package:ecos_main/common/models/route_models.dart';
import 'package:ecos_main/Screens/wrappers/shell_screen.dart';
import 'package:ecos_main/common/utils.dart';

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
  static GoRoute _idRouteBuilder({
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

  /// Creates a grouped route with optional bottom navigation
  static RouteBase groupedRoutes({
    required String root,
    required List<RouteBase> nestedRoutes,
    List<BottomNavigationBarItem>? bottomNavItems,
    bool enableState = false,
    String? Function(BuildContext, GoRouterState)? redirect,
    Widget Function(BuildContext, GoRouterState, StatefulNavigationShell?)?
        builder,
  }) {
    if (enableState && !Global.isEmpty(bottomNavItems)) {
      return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ShellScreen(
          bottomNavItems: bottomNavItems!,
          navigationShell: navigationShell,
        ),
        branches: nestedRoutes
            .map((route) => StatefulShellBranch(routes: [route]))
            .toList(),
      );
    }

    return GoRoute(
      path: root,
      redirect: redirect,
      builder: (context, state) =>
          builder?.call(context, state, null) ??
          _fallbackBuilder(context, state),
      routes: nestedRoutes,
    );
  }

  /// Nested route builder with optional stateful navigation
  static RouteBase nestedRouteBuilder({
    required Extension pathConfig,
    Widget Function(BuildContext, GoRouterState)? rootBuilder,
    required Widget Function(String, GoRouterState) detailBuilder,
    required Widget Function(String, GoRouterState) updateBuilder,
    bool enableState = false,
    String? Function(BuildContext, GoRouterState)? redirect,
    List<BottomNavigationBarItem>? bottomNavItems,
  }) {
    if (!enableState) {
      return GoRoute(
        path: pathConfig.root.path,
        redirect: redirect,
        builder: (context, state) =>
            rootBuilder?.call(context, state) ??
            _fallbackBuilder(context, state),
        routes: [
          _idRouteBuilder(
              path: pathConfig.detail.path,
              builder: detailBuilder,
              redirect: redirect),
          _idRouteBuilder(
              path: pathConfig.update.path,
              builder: updateBuilder,
              redirect: redirect),
        ],
      );
    }

    return StatefulShellRoute(
      builder: (context, state, navigationShell) =>
          rootBuilder?.call(context, state) ?? _fallbackBuilder(context, state),
      navigatorContainerBuilder: (context, navigationShell, children) =>
          Scaffold(
        body: children[navigationShell.currentIndex],
        bottomNavigationBar: bottomNavItems != null && bottomNavItems.isNotEmpty
            ? BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: navigationShell.goBranch,
                items: bottomNavItems,
              )
            : null,
      ),
      branches: [
        StatefulShellBranch(routes: [
          _idRouteBuilder(
              path: pathConfig.detail.path,
              builder: detailBuilder,
              redirect: redirect),
          _idRouteBuilder(
              path: pathConfig.update.path,
              builder: updateBuilder,
              redirect: redirect),
        ]),
      ],
    );
  }

  /// Creates a stateful shell route
  static StatefulShellRoute statefulShellRoute({
    required List<StatefulShellBranch> branches,
    required Widget Function(
            BuildContext, GoRouterState, StatefulNavigationShell)
        builder,
    String? Function(BuildContext, GoRouterState)? redirect,
    required Widget Function(
            BuildContext, StatefulNavigationShell, List<Widget>)
        navigatorContainerBuilder,
  }) {
    return StatefulShellRoute(
      builder: builder,
      navigatorContainerBuilder: navigatorContainerBuilder,
      branches: branches,
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
