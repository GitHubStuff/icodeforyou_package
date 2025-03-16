import 'package:flutter/material.dart';
import 'package:icodeforyou_example/gen/assets.gen.dart';
import 'package:icodeforyou_example/src/src.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

void main() {
  runApp(
    ThemeApp(
      fadeDuration: const Duration(milliseconds: 500),
      parentScreen: const ExampleHomeScreen(title: 'Example Home Page'),
      splashDuration: const Duration(milliseconds: 300),
      splashScreen: Assets.images.ic4u1024x1024.image(),

      /// ThemeData? darkTheme,
      /// ThemeData? lightTheme,
      darkThemeExtensions: [DateTimePickerThemeExtensionFactory.dark()],
      lightThemeExtensions: [DateTimePickerThemeExtensionFactory.light()],
    ),
  );
}

class DateTimePickerThemeExtensionFactory {
  // Factory instance for Dark Theme
  static DateTimePickerThemeExtension dark() {
    return const DateTimePickerThemeExtension(
      dateColor: Color(0xFF0A1A44), // Dark blue
      timeColor: Color(0xFF3A003A), // Dark purple
      textColor: Colors.white, // White text for contrast
      splashColor: Color(0xFF003300), // Dark green
    );
  }

  // Factory instance for Light Theme
  static DateTimePickerThemeExtension light() {
    return const DateTimePickerThemeExtension(
      dateColor: Color(0xFFFFE082), // Light amber/yellow
      timeColor: Color(0xFFFFD54F), // Light yellow/amber
      textColor: Colors.black, // Black text for contrast
      splashColor: Color(0xFFCCFF90), // Light-light-green for ripple effect
    );
  }
}
