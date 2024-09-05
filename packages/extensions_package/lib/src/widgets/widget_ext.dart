// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget hide(bool isVisible) => isVisible ? withOpacity(0) : this;

  Widget remove(bool isRemove) => isRemove ? const SizedBox.shrink() : this;

  Widget withBackground(Color color) => DecoratedBox(
        decoration: BoxDecoration(color: color),
        child: this,
      );

  Widget withBorder(
    Color color, {
    double width = 1.5,
    double radius = 0.0,
    BorderStyle style = BorderStyle.solid,
  }) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: width, style: style),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: this,
      );

  Widget withOpacity(double opacityValue) {
    assert(
      opacityValue >= 0.0 && opacityValue <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return Opacity(opacity: opacityValue, child: this);
  }

  Widget withPadding({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  Widget withPaddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget withSymmetricPadding({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget withWrap({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    Color color = Colors.transparent,
  }) =>
      ColoredBox(
        color: color,
        child: withPadding(left: left, right: right, top: top, bottom: bottom),
      );

  Widget withWrapAll(double value, {Color color = Colors.transparent}) =>
      withWrap(
        left: value,
        right: value,
        top: value,
        bottom: value,
        color: color,
      );
}
