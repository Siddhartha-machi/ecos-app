import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ecos_main/routes/routes.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp.router(
      title: 'Ecos App',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    ),
  ));
}
