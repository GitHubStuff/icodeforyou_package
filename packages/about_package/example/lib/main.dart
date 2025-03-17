import 'package:_template_app_flutter/src/src.dart'
    show Assets, ExampleHomeScreen;
import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

void main() {
  runApp(
    MaterialApp(
      home: StartupScreen(
        fadeDuration: const Duration(milliseconds: 500),
        homeScreen: const ExampleHomeScreen(title: 'Example Home Page'),
        splashDuration: const Duration(milliseconds: 300),
        splashScreen: Assets.images.demo960x581.image(),
        noSqlDB: NoSqlHive,
        splashTransition: SplashTransition.fadeScale,
      ),
    ),
  );
}
