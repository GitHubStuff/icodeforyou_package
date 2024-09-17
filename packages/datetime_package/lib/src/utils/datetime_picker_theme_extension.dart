import 'package:flutter/material.dart';

class DateTimePickerThemeExtension
    extends ThemeExtension<DateTimePickerThemeExtension> {
  const DateTimePickerThemeExtension({
    required this.dateColor,
    required this.timeColor,
    required this.textColor,
    required this.splashColor,
  });
  final Color? dateColor;
  final Color? timeColor;
  final Color? textColor;
  final Color? splashColor;

  @override
  DateTimePickerThemeExtension copyWith({
    Color? dateColor,
    Color? timeColor,
    Color? textColor,
    Color? splashColor,
  }) {
    return DateTimePickerThemeExtension(
      dateColor: dateColor ?? this.dateColor,
      timeColor: timeColor ?? this.timeColor,
      textColor: textColor ?? this.textColor,
      splashColor: splashColor ?? this.splashColor,
    );
  }

  @override
  DateTimePickerThemeExtension lerp(
    ThemeExtension<DateTimePickerThemeExtension>? other,
    double t,
  ) {
    if (other is! DateTimePickerThemeExtension) return this;
    return DateTimePickerThemeExtension(
      dateColor: Color.lerp(dateColor, other.dateColor, t),
      timeColor: Color.lerp(timeColor, other.timeColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
    );
  }
}
