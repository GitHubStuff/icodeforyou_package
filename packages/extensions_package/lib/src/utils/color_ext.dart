import 'package:flutter/material.dart' show Color;

extension ColorExt on Color {
  Color setOpacity(double opacity) {
    // NOTE: If set by running application the opacity is clamped to 0.0 - 1.0
    assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');
    int inline(double value) => (value * 255).toInt();
    final red = inline(r);
    final green = inline(g);
    final blue = inline(b);
    return Color.fromRGBO(red, green, blue, opacity.clamp(0.0, 1.0));
  }
}
