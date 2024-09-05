// ignore_for_file: avoid_escaping_inner_quotes, avoid_redundant_argument_values

import 'package:extensions_package/src/package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('DateTimeExt.utcString', () {
    test('should return formatted UTC string for a given DateTime', () {
      // Arrange
      final dateTime = DateTime(2024, 8, 29, 15, 45, 30, 123);
      final expected =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS \'Z\'').format(dateTime.toUtc());

      // Act
      final result = dateTime.utcString();

      // Assert
      expect(result, expected);
    });

    test('should return formatted UTC string for a custom DateTime input', () {
      // Arrange
      final customDateTime = DateTime(2023, 12, 25, 10, 30, 45, 456);
      final expected = DateFormat('yyyy-MM-dd HH:mm:ss.SSS \'Z\'')
          .format(customDateTime.toUtc());

      // Act
      final result = customDateTime.utcString();

      // Assert
      expect(result, expected);
    });

    test('should handle DateTime with zero milliseconds', () {
      // Arrange
      final dateTime = DateTime(2024, 1, 1, 0, 0, 0, 0);
      final expected =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS \'Z\'').format(dateTime.toUtc());

      // Act
      final result = dateTime.utcString();

      // Assert
      expect(result, expected);
    });

    test(
        'should convert a UTC string back to DateTime and match the source DateTime',
        () {
      final originalDateTime = DateTime(2024, 8, 29, 15, 45, 30, 123);
      final utcString = originalDateTime.utcString();

      final parsedDateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS \'Z\'').parseUtc(utcString);

      expect(parsedDateTime, originalDateTime.toUtc());
    });

    test('should handle DateTime with non-zero milliseconds', () {
      // Arrange
      final dateTime = DateTime(2024, 8, 29, 0, 0, 0, 999);
      final expected =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS \'Z\'').format(dateTime.toUtc());

      // Act
      final result = dateTime.utcString();

      // Assert
      expect(result, expected);
    });
  });
}
