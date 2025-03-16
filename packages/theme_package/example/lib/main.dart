import 'package:flutter/material.dart';
import 'package:theme_example/src/screens/example_homescreen.dart';
import 'package:theme_package/theme_package.dart';

void main() {
  runApp(
    ThemeApp(
      fadeDuration: const Duration(milliseconds: 500),
      parentScreen: const ExampleHomeScreen(title: 'Example Home Page'),
      splashDuration: const Duration(milliseconds: 300),
      splashScreen: Image.asset('assets/images/demo1024x1024.png'),

      /// ThemeData? darkTheme,
      /// ThemeData? lightTheme,
      /// List<ThemeExtension> darkThemeExtensions;
      /// List<ThemeExtension> lightThemeExtensions;
    ),
  );
}
