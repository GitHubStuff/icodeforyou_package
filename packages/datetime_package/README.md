# DATETIME_PACKAGE

## Features

Provides a Date/Time picker that is lean and compact that uses scrolling windows to set the DateTime.

Extends DateTime:

 copyWith() to copy year, month, day, hour, minuts, seconds, millsecond, and microsecond.

Classes:

DateTimeDifference - Construted using two DateTimes, and first time unit, compares two dates and the class isntance has the delta between each properity.

## Getting started

## Usage

DateTimePickerThemeExtension:

Add this to the ThemeExtension to define the colors used in the DateTimeScrollPicker

```dart
const DateTimePickerThemeExtension({
    required this.dateColor,
    required this.timeColor,
    required this.textColor,
    required this.splashColor,
})
```

Compare two DateTime values and get properties.

```dart
final m = DateTimeDifference(DateTime startEvent, DateTIme endEvent, firstTimeUnit = DateTimeUnit.year,
         DateTimeUnit precision = DateTimeUnit.second);
```

Extensions:

```dart
final d = DateTimeExt.daysIn(int month, int year);   // Number of days in a month

final d = DateTime().daysInMonth()  // Number of days in a month of the current DateTime.

final b = DateTimeExt.isLeap(int year); //If the given year is a leap year.

// Truncates a DateTime unit at the given Unit make
final dt = DateTime().truncate(DateTimeUnit atDateTimeUnit = DateTimeUsing.second);
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
