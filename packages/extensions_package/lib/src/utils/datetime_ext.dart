extension DateTimeExt on DateTime {
  String utcString() => toUtc().toIso8601String();
}
