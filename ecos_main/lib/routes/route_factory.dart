import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos_main/common/screens/empty_route.dart';

class CustomRouteFactory {
  static Widget _fallbackBuilder(BuildContext ctx, GoRouterState state) {
    return EmptyRoute(state.path ?? 'Unknown path');
  }

  static GoRoute idRouteBuilder({
    required String path,
    required String name,
    required Widget Function(String, GoRouterState) builder,
  }) {
    return GoRoute(
      path: path,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';

        if (id.isEmpty) {
          throw Exception('Invalid $name Id provided.');
        }

        return builder(id, state);
      },
    );
  }

  static GoRoute staticRouteBuilder({
    required String path,
    Widget Function(BuildContext, GoRouterState)? builder,
  }) {
    return GoRoute(
      path: path,
      builder: builder ?? _fallbackBuilder,
    );
  }

  static GoRoute nestedRouteBuilder({
    required String basePath,
    required String name,
    Widget Function(BuildContext, GoRouterState)? rootBuilder,
    required Widget Function(String, GoRouterState) detailBuilder,
    required Widget Function(String, GoRouterState) updateBuilder,
    List<RouteBase> specialRoutes = const <RouteBase>[],
  }) {
    return GoRoute(
      path: '/$basePath',
      builder: rootBuilder,
      routes: [
        idRouteBuilder(
          path: '/$basePath/detail/:id',
          name: name,
          builder: detailBuilder,
        ),
        idRouteBuilder(
          path: '/$basePath/update/:id',
          name: name,
          builder: updateBuilder,
        ),
        ...specialRoutes
      ],
    );
  }
}
