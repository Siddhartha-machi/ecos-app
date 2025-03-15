import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

import 'package:ecos_main/core/app/routes.dart';

void main() async {
  final customTheme = await loadCustomTheme();

  runApp(ProviderScope(
      child: MaterialApp.router(
        title: 'Ecos App',
        theme: customTheme,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
  ));
}

Future<ThemeData> loadCustomTheme() async {
  // Fetch custom theme for the user from server
  // TODO: task defered

  // Need to ensure flutter is initialized before accessing assets.
  WidgetsFlutterBinding.ensureInitialized();

  var themeStr = await rootBundle.loadString('assets/themes/light_theme.json');
  var themeJson = jsonDecode(themeStr);
  final lightTheme = ThemeDecoder.decodeThemeData(themeJson)!;

  // TODO: defered dark theme addition
  // themeStr = await rootBundle.loadString('assets/themes/dark_theme.json');
  // themeJson = jsonDecode(themeStr);
  // final darkThem = ThemeDecoder.decodeThemeData(themeJson)!;

  return lightTheme;
}
