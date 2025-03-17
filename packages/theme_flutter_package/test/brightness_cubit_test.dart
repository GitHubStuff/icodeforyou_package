import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

// Fake implementation for NoSqlBox<String>
class FakeNoSqlBox implements NoSqlBox<String> {
  String? storedValue;
  bool closed = false;

  @override
  Future<bool> put(dynamic key, String value) async {
    storedValue = value;
    return true;
  }

  @override
  Future<String?> get(dynamic key, {String? defaultValue}) async {
    return storedValue ?? defaultValue;
  }

  @override
  Future<void> close() async {
    closed = true;
  }
}

// Fake implementation for NoSqlDB that returns our FakeNoSqlBox.
class FakeNoSqlDB implements NoSqlDB {
  FakeNoSqlDB(this.box);
  final FakeNoSqlBox box;

  @override
  Future<NoSqlBox<T>?> openBox<T>(String name) async {
    // Assume T is String for our tests.
    return box as NoSqlBox<T>;
  }

  @override
  FutureOr<bool> deleteFromDevice() {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> init({String dirName = 'nosqldb'}) {
    throw UnimplementedError();
  }
}

void main() {
  group('BrightnessCubit', () {
    blocTest<BrightnessCubit, Brightness>(
      'emits Brightness.light when stored value is "light"',
      build: () {
        // Create a fake box that returns "light" for the brightness.
        final fakeBox = FakeNoSqlBox()..storedValue = 'light';
        final fakeDB = FakeNoSqlDB(fakeBox);
        return BrightnessCubit(noSqlDb: fakeDB);
      },
      // Allow a brief delay for the async _init to complete.
      wait: const Duration(milliseconds: 10),
      // The cubit is constructed with an initial state of Brightness.dark.
      // _init then reads the stored "light" value and emits Brightness.light.
      expect: () => [Brightness.light],
    );

    blocTest<BrightnessCubit, Brightness>(
      'emits Brightness.dark then Brightness.light when setThemeMode is called with AppThemeMode.light',
      build: () {
        // Start with a stored value of "dark".
        final fakeBox = FakeNoSqlBox()..storedValue = 'dark';
        final fakeDB = FakeNoSqlDB(fakeBox);
        return BrightnessCubit(noSqlDb: fakeDB);
      },
      wait: const Duration(milliseconds: 10),
      act: (cubit) async {
        // After initialization (which emits Brightness.dark), change theme mode.
        await cubit.setThemeMode(AppThemeMode.light);
      },
      // Expect the first emission from _init (using stored "dark") followed by the update.
      expect: () => [Brightness.dark, Brightness.light],
    );

    test(
      'close() unregisters brightness callback and closes the box',
      () async {
        final fakeBox = FakeNoSqlBox()..storedValue = 'dark';
        final fakeDB = FakeNoSqlDB(fakeBox);
        final cubit = BrightnessCubit(noSqlDb: fakeDB);
        // Allow time for initialization.
        await Future<void>.delayed(const Duration(milliseconds: 10));
        await cubit.close();
        // Verify that the platform brightness callback is cleared.
        expect(PlatformDispatcher.instance.onPlatformBrightnessChanged, isNull);
        // And that the underlying box was closed.
        expect(fakeBox.closed, isTrue);
      },
    );
  });
}
