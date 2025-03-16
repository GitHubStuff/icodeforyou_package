import 'package:datetime_package/src/src.dart';

enum DateTimeUnit {
  year,
  month,
  day,
  hour,
  minute,
  second,
  msec,
  usec;

  static const num kMonthsPerYear = 12;
  static const num kHoursPerDay = 24;
  static const num kMinutesPerHour = 60;
  static const num kSecondsPerMinute = 60;
  static const num kMsecPerSecond = 1000;
  static const num kUsecPerMsec = 1000;

  static const num kDaysPlaceholder = 0;
  static const num kDaysJanuary = 31;
  static const num kDaysFebruary = 28;
  static const num kDaysFebruaryLeap = 29;
  static const num kDaysMarch = 31;
  static const num kDaysApril = 30;
  static const num kDaysMay = 31;
  static const num kDaysJune = 30;
  static const num kDaysJuly = 31;
  static const num kDaysAugust = 31;
  static const num kDaysSeptember = 30;
  static const num kDaysOctober = 31;
  static const num kDaysNovember = 30;
  static const num kDaysDecember = 31;

  static DateTime makeLocal(
    DateTime? dateTime, {
    DateTimeUnit truncateAt = DateTimeUnit.second,
  }) => (dateTime ?? DateTime.now()).toLocal().truncate(
    atDateTimeUnit: truncateAt,
  );

  /// Creates a UTC DateTime object with the specified DateTimeUnit precision.
  ///
  /// - [dateTime]: The DateTime object to be rounded (default is the current system time).
  /// - [truncateAt]: The DateTimeUnit at which the DateTime should be rounded (default is milliseconds).
  static DateTime makeUtc(
    DateTime? dateTime, {
    DateTimeUnit truncateAt = DateTimeUnit.second,
  }) =>
      (dateTime ?? DateTime.now()).toUtc().truncate(atDateTimeUnit: truncateAt);

  /// Returns the next DateTimeUnit from the current DateTimeUnit
  /// If the current DateTimeUnit is the last one, it will return null
  DateTimeUnit? get next {
    if (this == usec) return null;
    final index = DateTimeUnit.values.indexOf(this);
    return DateTimeUnit.values[index + 1];
  }

  /// Returns a set of DateTimeUnits from the current DateTimeUnit to the last DateTimeUnit
  /// Helper method to get a sublist of DateTimeUnits
  Set<DateTimeUnit> sublist() {
    final index = DateTimeUnit.values.indexOf(this);
    return Set<DateTimeUnit>.from(DateTimeUnit.values.sublist(index));
  }
}

/// -----------------------------------
/// Enum to represent the relation between two DateTime objects
enum DateTimeOrdering {
  before,
  now,
  after;

  /// Returns the relation between startEvent and endEvent
  /// If startEvent is before endEvent, it returns DateTimeRelation.before
  /// If startEvent is after endEvent, it returns DateTimeRelation.after
  /// If startEvent is the same as endEvent, it returns DateTimeRelation.now
  static DateTimeOrdering direction(DateTime startEvent, DateTime endEvent) {
    if (startEvent.isBefore(endEvent)) return DateTimeOrdering.before;
    if (startEvent.isAfter(endEvent)) return DateTimeOrdering.after;
    return DateTimeOrdering.now;
  }
}
