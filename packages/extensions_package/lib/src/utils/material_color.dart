// Improved readability
// ignore_for_file: prefer_int_literals

import 'package:extensions_package/src/utils/utils.dart';
import 'package:flutter/material.dart';

// Function to create a MaterialColor from any color
MaterialColor createMaterialColor(Color color) {
  final colorMap = {
    050: color.setOpacity(0.1),
    100: color.setOpacity(0.2),
    200: color.setOpacity(0.3),
    300: color.setOpacity(0.4),
    400: color.setOpacity(0.5),
    500: color.setOpacity(0.6),
    600: color.setOpacity(0.7),
    700: color.setOpacity(0.8),
    800: color.setOpacity(0.9),
    900: color.setOpacity(1.0),
  };
  return MaterialColor(color.toARGB32(), colorMap);
}
