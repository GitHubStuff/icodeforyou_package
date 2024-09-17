import 'package:datetime_package/src/src.dart';

extension DateTimeNum on num {
  /// Converts the numeric value to months.
  num asMonths() => this * DateTimeUnit.kMonthsPerYear;

  /// Converts the numeric value to hours.
  num asHours() => this * DateTimeUnit.kHoursPerDay;

  /// Converts the numeric value to minutes.
  num asMinutes() => this * DateTimeUnit.kMinutesPerHour;

  /// Converts the numeric value to seconds.
  num asSeconds() => this * DateTimeUnit.kSecondsPerMinute;

  /// Converts the numeric value to milliseconds.
  num asMilliseconds() => this * DateTimeUnit.kMsecPerSecond;

  /// Converts the numeric value to microseconds.
  num asMicroseconds() => this * DateTimeUnit.kUsecPerMsec;
}
