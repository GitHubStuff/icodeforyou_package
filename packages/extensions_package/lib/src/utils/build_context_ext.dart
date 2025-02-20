import 'dart:math';

import 'package:extensions_package/src/typedefs/typedefs.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;
  void hideKeyboard() {
    if (!FocusScope.of(this).hasPrimaryFocus) FocusScope.of(this).unfocus();
  }
}

class Responsive {
  static double width(
    double w, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    double? overrideWidth,
  }) {
    assert(w >= 0.0 && w <= 1.0, 'Invalid width percentage: $w');
    assert(minWidth >= 0, 'Invalid minWidth: $minWidth');
    assert(maxWidth >= 0, 'Invalid maxWidth: $maxWidth');
    final context = Global.context;
    final width =
        (overrideWidth == null)
            ? MediaQuery.of(context).size.width
            : overrideWidth;
    return max(minWidth, min(maxWidth, width * w));
  }

  static double height(
    double h, {
    double minHeight = 0,
    double maxHeight = double.infinity,
    double? overrideHeight,
  }) {
    assert(h >= 0.0 && h <= 1.0, 'Invalid height percentage: $h');
    assert(minHeight >= 0, 'Invalid min: $minHeight');
    assert(maxHeight >= 0, 'Invalid max: $maxHeight');
    final context = Global.context;
    final height =
        (overrideHeight == null)
            ? MediaQuery.of(context).size.height
            : overrideHeight;
    return max(minHeight, min(maxHeight, height * h));
  }
}
