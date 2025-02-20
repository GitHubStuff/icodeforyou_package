// Improves readability
// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';

extension TextExtensions on Text {
  Text fontSize(double fontSize) => Text(
    data!,
    style:
        style == null
            ? TextStyle(fontSize: fontSize)
            : style?.copyWith(fontSize: fontSize),
  );

  /// Normal or italic
  Text fontStyle(FontStyle fontStyle) => Text(
    data!,
    style:
        style == null
            ? TextStyle(fontStyle: fontStyle)
            : style?.copyWith(fontStyle: fontStyle),
  );

  /// Normal, bold, weighted
  Text fontWeight(FontWeight fontWeight) => Text(
    data!,
    style:
        style == null
            ? TextStyle(fontWeight: fontWeight)
            : style?.copyWith(fontWeight: fontWeight),
  );

  Text textColor(Color color) => Text(
    data!,
    style:
        style == null ? TextStyle(color: color) : style?.copyWith(color: color),
  );
}
