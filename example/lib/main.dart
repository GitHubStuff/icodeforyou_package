import 'package:_template_app_flutter/src/src.dart';
import 'package:flutter/material.dart';
import '../icodeforyou_package';

void main() {
  FLog().i('SampleApp');
  FileInfo.init();
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
