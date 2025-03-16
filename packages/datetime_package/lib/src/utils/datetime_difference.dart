// Improve readability
// ignore_for_file: omit_local_variable_types

import 'package:datetime_package/src/src.dart';
import 'package:intl/intl.dart';

typedef TimeMap = Map<String, num>;

(T, T) swap<T>(T a, T b) => (b, a);

/// Class that calculates the difference between two DateTime objects.
class DateTimeDifference {
  /// Constructor for DateTimeDifference.
  DateTimeDifference({
    required DateTime startEvent,
    required DateTime endEvent,
    DateTimeUnit firstDateTimeUnit = DateTimeUnit.year,
    DateTimeUnit precision = DateTimeUnit.second,
  }) : finishDateTime = endEvent,
       startDateTime = startEvent,
       fieldSet = firstDateTimeUnit.sublist(),
       direction = DateTimeOrdering.direction(startEvent, endEvent) {
    if (direction == DateTimeOrdering.now) {
      _setItems(); // Set all items to null.
      return;
    }

    startEvent = DateTimeUnit.makeUtc(startEvent, truncateAt: precision);
    endEvent = DateTimeUnit.makeUtc(endEvent, truncateAt: precision);

    if (direction == DateTimeOrdering.before) {
      (startEvent, endEvent) = swap<DateTime>(startEvent, endEvent);
    }

    final TimeMap timeDifferences = _calculateDeltas(startEvent, endEvent);

    _adjustNegativeValues(timeDifferences);

    final Duration difference = startEvent.difference(endEvent);
    _handleFieldSetDifferences(timeDifferences, difference);

    _setItems(
      years: timeDifferences[DateTimeUnit.year.name],
      months: timeDifferences[DateTimeUnit.month.name],
      days: timeDifferences[DateTimeUnit.day.name],
      hours: timeDifferences[DateTimeUnit.hour.name],
      minutes: timeDifferences[DateTimeUnit.minute.name],
      seconds: timeDifferences[DateTimeUnit.second.name],
      milliseconds: timeDifferences[DateTimeUnit.msec.name],
      microseconds: timeDifferences[DateTimeUnit.usec.name],
    );
  }

  /// These properties are available when the constructor completes.
  final DateTime finishDateTime;
  final DateTime startDateTime;
  num? years;
  num? months;
  num? days;
  num? hours;
  num? minutes;
  num? seconds;
  num? msecs;
  num? usecs;
  final DateTimeOrdering direction;
  final Set<DateTimeUnit> fieldSet;

  TimeMap _calculateDeltas(DateTime start, DateTime end) {
    return {
      DateTimeUnit.year.name: start.year - end.year,
      DateTimeUnit.month.name: start.month - end.month,
      DateTimeUnit.day.name: start.day - end.day,
      DateTimeUnit.hour.name: start.hour - end.hour,
      DateTimeUnit.minute.name: start.minute - end.minute,
      DateTimeUnit.second.name: start.second - end.second,
      DateTimeUnit.msec.name: start.millisecond - end.millisecond,
      DateTimeUnit.usec.name: start.microsecond - end.microsecond,
    };
  }

  void _handleFieldSetDifferences(
    Map<String, num> timeDifferences,
    Duration difference,
  ) {
    final units = {
      DateTimeUnit.year: () {
        timeDifferences[DateTimeUnit.month.name] =
            (timeDifferences[DateTimeUnit.month.name] ?? 0) +
            timeDifferences[DateTimeUnit.year.name]!.asMonths();
        timeDifferences[DateTimeUnit.year.name] = 0;
      },
      DateTimeUnit.month: () {
        timeDifferences[DateTimeUnit.day.name] = difference.inDays;
        timeDifferences[DateTimeUnit.month.name] = 0;
      },
      DateTimeUnit.day: () {
        timeDifferences[DateTimeUnit.hour.name] = difference.inHours;
        timeDifferences[DateTimeUnit.day.name] = 0;
      },
      DateTimeUnit.hour: () {
        timeDifferences[DateTimeUnit.minute.name] = difference.inMinutes;
        timeDifferences[DateTimeUnit.hour.name] = 0;
      },
      DateTimeUnit.minute: () {
        timeDifferences[DateTimeUnit.second.name] = difference.inSeconds;
        timeDifferences[DateTimeUnit.minute.name] = 0;
      },
      DateTimeUnit.second: () {
        timeDifferences[DateTimeUnit.msec.name] = difference.inMilliseconds;
        timeDifferences[DateTimeUnit.second.name] = 0;
      },
      DateTimeUnit.msec: () {
        timeDifferences[DateTimeUnit.usec.name] = difference.inMicroseconds;
        timeDifferences[DateTimeUnit.msec.name] = 0;
      },
    };

    for (final unit in units.keys) {
      if (!fieldSet.contains(unit)) {
        units[unit]!();
      }
    }
  }

  void _adjustNegativeValues(Map<String, num> timeDifferences) {
    final DateTime adjustedDateTime =
        (direction == DateTimeOrdering.before) ? finishDateTime : startDateTime;

    void adjust(String unit, String largerUnit, num threshold) {
      if (timeDifferences[unit]! < 0) {
        timeDifferences[largerUnit] = (timeDifferences[largerUnit] ?? 0) - 1;
        timeDifferences[unit] = (timeDifferences[unit] ?? 0) + threshold;
      }
    }

    adjust(
      DateTimeUnit.usec.name,
      DateTimeUnit.msec.name,
      DateTimeUnit.kUsecPerMsec,
    );
    adjust(
      DateTimeUnit.msec.name,
      DateTimeUnit.second.name,
      DateTimeUnit.kMsecPerSecond,
    );
    adjust(
      DateTimeUnit.second.name,
      DateTimeUnit.minute.name,
      DateTimeUnit.kSecondsPerMinute,
    );
    adjust(
      DateTimeUnit.minute.name,
      DateTimeUnit.hour.name,
      DateTimeUnit.kMinutesPerHour,
    );
    adjust(
      DateTimeUnit.hour.name,
      DateTimeUnit.day.name,
      DateTimeUnit.kHoursPerDay,
    );

    if (timeDifferences[DateTimeUnit.day.name]! < 0) {
      timeDifferences[DateTimeUnit.month.name] =
          (timeDifferences[DateTimeUnit.month.name] ?? 0) - 1;
      final int numberOfDaysInMonth =
          DateTime(adjustedDateTime.year, adjustedDateTime.month, 0).day;
      timeDifferences[DateTimeUnit.day.name] =
          (timeDifferences[DateTimeUnit.day.name] ?? 0) + numberOfDaysInMonth;
    }

    adjust(
      DateTimeUnit.month.name,
      DateTimeUnit.year.name,
      DateTimeUnit.kMonthsPerYear,
    );
  }

  @override
  String toString() {
    if (direction == DateTimeOrdering.now) return '00:00:00';

    var result = '';
    if (usecs != null && usecs! > 0) {
      final milliSeconds = msecs!.toInt() * 1000;
      result += ".${NumberFormat('000000').format(milliSeconds)}";
    }
    if (result.isEmpty && msecs != null && msecs! > 0) {
      result += ".${NumberFormat('000').format(msecs)}";
    }
    result +=
        "${NumberFormat('00').format(hours ?? 0)}:${NumberFormat('00').format(minutes ?? 0)}:${NumberFormat('00').format(seconds ?? 0)}";

    final months = NumberFormat('00').format(this.months ?? 0);
    final days = NumberFormat('00').format(this.days ?? 0);

    if (years != null && years! > 0) {
      result = '$years $months $days $result';
    } else if (this.months != null && this.months! > 0) {
      result = '${this.months} $days $result';
    } else if (this.days != null && this.days! > 0) {
      result = '${this.days} $result';
    }

    if (direction == DateTimeOrdering.after) result = '-$result';

    return result;
  }

  void _setItems({
    num? years,
    num? months,
    num? days,
    num? hours,
    num? minutes,
    num? seconds,
    num? milliseconds,
    num? microseconds,
  }) {
    this.years = _isFieldSet(DateTimeUnit.year) ? years : null;
    this.months = _isFieldSet(DateTimeUnit.month) ? months : null;
    this.days = _isFieldSet(DateTimeUnit.day) ? days : null;
    this.hours = _isFieldSet(DateTimeUnit.hour) ? hours : null;
    this.minutes = _isFieldSet(DateTimeUnit.minute) ? minutes : null;
    this.seconds = _isFieldSet(DateTimeUnit.second) ? seconds : null;
    msecs = _isFieldSet(DateTimeUnit.msec) ? milliseconds : null;
    usecs = _isFieldSet(DateTimeUnit.usec) ? microseconds : null;
  }

  // Helper function to check if a unit is in the fieldSet
  bool _isFieldSet(DateTimeUnit unit) => fieldSet.contains(unit);
}

///*************************************************************

/// A class that calculates the difference between two DateTime objects.
class DateTimeDifferenceOriginal {
  /// Constructor for DateTimeDifference.
  DateTimeDifferenceOriginal({
    required DateTime startEvent,
    required DateTime endEvent,
    DateTimeUnit firstDateTimeUnit = DateTimeUnit.year,
  }) : finishDateTime = endEvent,
       startDateTime = startEvent,
       fieldSet = firstDateTimeUnit.sublist(),
       direction = DateTimeOrdering.direction(startEvent, endEvent) {
    if (direction == DateTimeOrdering.now) {
      _setItems(); // Set all items to null.
      return;
    }

    startEvent = DateTimeUnit.makeUtc(startEvent);
    endEvent = DateTimeUnit.makeUtc(endEvent);

    if (direction == DateTimeOrdering.before) {
      final temp = startEvent;
      startEvent = endEvent;
      endEvent = temp;
    }

    final timeDifferences = _calculateTimeDifferences(startEvent, endEvent);
    _adjustNegativeValues(timeDifferences);

    if (!fieldSet.contains(DateTimeUnit.year)) {
      timeDifferences[DateTimeUnit.month.name] =
          (timeDifferences[DateTimeUnit.month.name] ?? 0) +
          timeDifferences[DateTimeUnit.year.name]!.asMonths();
      timeDifferences[DateTimeUnit.year.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.month)) {
      timeDifferences[DateTimeUnit.day.name] =
          startEvent.difference(endEvent).inDays;
      timeDifferences[DateTimeUnit.month.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.day)) {
      timeDifferences[DateTimeUnit.hour.name] =
          startEvent.difference(endEvent).inHours;
      timeDifferences[DateTimeUnit.day.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.hour)) {
      timeDifferences[DateTimeUnit.minute.name] =
          startEvent.difference(endEvent).inMinutes;
      timeDifferences[DateTimeUnit.hour.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.minute)) {
      timeDifferences[DateTimeUnit.second.name] =
          startEvent.difference(endEvent).inSeconds;
      timeDifferences[DateTimeUnit.minute.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.second)) {
      timeDifferences[DateTimeUnit.msec.name] =
          startEvent.difference(endEvent).inMilliseconds;
      timeDifferences[DateTimeUnit.second.name] = 0;
    }
    if (!fieldSet.contains(DateTimeUnit.msec)) {
      timeDifferences[DateTimeUnit.usec.name] =
          startEvent.difference(endEvent).inMicroseconds;
      timeDifferences[DateTimeUnit.msec.name] = 0;
    }

    _setItems(
      years: timeDifferences[DateTimeUnit.year.name],
      months: timeDifferences[DateTimeUnit.month.name],
      days: timeDifferences[DateTimeUnit.day.name],
      hours: timeDifferences[DateTimeUnit.hour.name],
      minutes: timeDifferences[DateTimeUnit.minute.name],
      seconds: timeDifferences[DateTimeUnit.second.name],
      milliseconds: timeDifferences[DateTimeUnit.msec.name],
      microseconds: timeDifferences[DateTimeUnit.usec.name],
    );
  }
  late final DateTime finishDateTime;
  late final DateTime startDateTime;
  late final num? years;
  late final num? months;
  late final num? days;
  late final num? hours;
  late final num? minutes;
  late final num? seconds;
  late final num? msecs;
  late final num? usecs;
  late final DateTimeOrdering direction;
  late final Set<DateTimeUnit> fieldSet;

  Map<String, num> _calculateTimeDifferences(DateTime start, DateTime end) {
    return {
      DateTimeUnit.year.name: start.year - end.year,
      DateTimeUnit.month.name: start.month - end.month,
      DateTimeUnit.day.name: start.day - end.day,
      DateTimeUnit.hour.name: start.hour - end.hour,
      DateTimeUnit.minute.name: start.minute - end.minute,
      DateTimeUnit.second.name: start.second - end.second,
      DateTimeUnit.msec.name: start.millisecond - end.millisecond,
      DateTimeUnit.usec.name: start.microsecond - end.microsecond,
    };
  }

  void _adjustNegativeValues(Map<String, num> timeDifferences) {
    final DateTime adjustedDateTime =
        (direction == DateTimeOrdering.before) ? finishDateTime : startDateTime;

    if (timeDifferences[DateTimeUnit.usec.name]! < 0) {
      timeDifferences[DateTimeUnit.msec.name] =
          (timeDifferences[DateTimeUnit.msec.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.usec.name] =
          (timeDifferences[DateTimeUnit.usec.name] ?? 0) +
          DateTimeUnit.kUsecPerMsec;
    }
    if (timeDifferences[DateTimeUnit.msec.name]! < 0) {
      timeDifferences[DateTimeUnit.second.name] =
          (timeDifferences[DateTimeUnit.second.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.msec.name] =
          (timeDifferences[DateTimeUnit.msec.name] ?? 0) +
          DateTimeUnit.kMsecPerSecond;
    }
    if (timeDifferences[DateTimeUnit.second.name]! < 0) {
      timeDifferences[DateTimeUnit.minute.name] =
          (timeDifferences[DateTimeUnit.minute.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.second.name] =
          (timeDifferences[DateTimeUnit.second.name] ?? 0) +
          DateTimeUnit.kSecondsPerMinute;
    }
    if (timeDifferences[DateTimeUnit.minute.name]! < 0) {
      timeDifferences[DateTimeUnit.hour.name] =
          (timeDifferences[DateTimeUnit.hour.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.minute.name] =
          (timeDifferences[DateTimeUnit.minute.name] ?? 0) +
          DateTimeUnit.kMinutesPerHour;
    }
    if (timeDifferences[DateTimeUnit.hour.name]! < 0) {
      timeDifferences[DateTimeUnit.day.name] =
          (timeDifferences[DateTimeUnit.day.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.hour.name] =
          (timeDifferences[DateTimeUnit.hour.name] ?? 0) +
          DateTimeUnit.kHoursPerDay;
    }
    if (timeDifferences[DateTimeUnit.day.name]! < 0) {
      timeDifferences[DateTimeUnit.month.name] =
          (timeDifferences[DateTimeUnit.month.name] ?? 0) - 1;
      final int numberOfDaysInMonth =
          DateTime(adjustedDateTime.year, adjustedDateTime.month, 0).day;
      timeDifferences[DateTimeUnit.day.name] =
          (timeDifferences[DateTimeUnit.day.name] ?? 0) + numberOfDaysInMonth;
    }
    if (timeDifferences[DateTimeUnit.month.name]! < 0) {
      timeDifferences[DateTimeUnit.year.name] =
          (timeDifferences[DateTimeUnit.year.name] ?? 0) - 1;
      timeDifferences[DateTimeUnit.month.name] =
          (timeDifferences[DateTimeUnit.month.name] ?? 0) +
          DateTimeUnit.kMonthsPerYear;
    }
  }

  @override
  String toString() {
    if (direction == DateTimeOrdering.now) return '00:00:00';

    var result = '';
    if (usecs != null && usecs! > 0) {
      final milliSeconds = msecs!.toInt() * 1000;
      result += ".${NumberFormat('000000').format(milliSeconds)}";
    }
    if (result.isEmpty && msecs != null && msecs! > 0) {
      result += ".${NumberFormat('000').format(msecs)}";
    }
    result +=
        "${NumberFormat('00').format(hours ?? 0)}:${NumberFormat('00').format(minutes ?? 0)}:${NumberFormat('00').format(seconds ?? 0)}";

    final months = NumberFormat('00').format(this.months ?? 0);
    final days = NumberFormat('00').format(this.days ?? 0);

    if (years != null && years! > 0) {
      result = '$years $months $days $result';
    } else if (this.months != null && this.months! > 0) {
      result = '${this.months} $days $result';
    } else if (this.days != null && this.days! > 0) {
      result = '${this.days} $result';
    }

    if (direction == DateTimeOrdering.after) result = '-$result';

    return result;
  }

  void _setItems({
    num? years,
    num? months,
    num? days,
    num? hours,
    num? minutes,
    num? seconds,
    num? milliseconds,
    num? microseconds,
  }) {
    this.years = fieldSet.contains(DateTimeUnit.year) ? years : null;
    this.months = fieldSet.contains(DateTimeUnit.month) ? months : null;
    this.days = fieldSet.contains(DateTimeUnit.day) ? days : null;
    this.hours = fieldSet.contains(DateTimeUnit.hour) ? hours : null;
    this.minutes = fieldSet.contains(DateTimeUnit.minute) ? minutes : null;
    this.seconds = fieldSet.contains(DateTimeUnit.second) ? seconds : null;
    msecs = fieldSet.contains(DateTimeUnit.msec) ? milliseconds : null;
    usecs = fieldSet.contains(DateTimeUnit.usec) ? microseconds : null;
  }
}
