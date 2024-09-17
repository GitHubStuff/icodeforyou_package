import 'package:datetime_package/src/src.dart';

extension DateTimeExt on DateTime {
  static int daysIn({required int month, required int year}) {
    if (month == 2) return isLeap(year: year) ? 29 : 28;
    return [4, 6, 9, 11].contains(month) ? 30 : 31;
  }

  int daysInMonth() => daysIn(month: month, year: year);

  static bool isLeap({required int year}) =>
      year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  bool isLeapYear() => isLeap(year: year);

  /// Truncates the DateTime to the specified DateTimeUnit precision.
  DateTime truncate({DateTimeUnit atDateTimeUnit = DateTimeUnit.second}) {
    final skipUnits = atDateTimeUnit.next?.sublist() ?? {};
    final m = isUtc ? DateTime.utc : DateTime.new;
    return m(
      skipUnits.contains(DateTimeUnit.year) ? 0 : year,
      skipUnits.contains(DateTimeUnit.month) ? 1 : month,
      skipUnits.contains(DateTimeUnit.day) ? 1 : day,
      skipUnits.contains(DateTimeUnit.hour) ? 0 : hour,
      skipUnits.contains(DateTimeUnit.minute) ? 0 : minute,
      skipUnits.contains(DateTimeUnit.second) ? 0 : second,
      skipUnits.contains(DateTimeUnit.msec) ? 0 : millisecond,
      skipUnits.contains(DateTimeUnit.usec) ? 0 : microsecond,
    );
  }
}
