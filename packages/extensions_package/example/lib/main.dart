import 'package:extensions_package_example/src/src.dart';
import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

void main() {
  runApp(
    ThemeApp(
      fadeDuration: const Duration(milliseconds: 500),
      parentScreen: const ExampleHomeScreen(title: 'Example Home Page'),
      splashDuration: const Duration(milliseconds: 300),
      splashScreen: Image.asset('assets/images/demo1024x1024.png'),

      /// ThemeData? darkTheme,
      /// ThemeData? lightTheme,
    ),
  );
}
