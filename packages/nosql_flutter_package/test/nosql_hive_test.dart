// test/nosql_hive_test.dart

// ignore_for_file: avoid_slow_async_io

import 'dart:async' show Completer;
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart' show Box, Hive;

import 'package:nosql_flutter_package/src/nosql_flutter_package.dart'
    show NoSqlHiveBox;
import 'package:nosql_flutter_package/src/nosql_hive/nosql_hive_db.dart'; // adjust the import based on your file structure
// ignore: library_prefixes
import 'package:path/path.dart' as P;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// A fake PathProviderPlatform that returns a temporary directory.
class FakePathProviderPlatform extends PathProviderPlatform {
  FakePathProviderPlatform(this.fakePath);
  final String fakePath;

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return fakePath;
  }
}

Future<void> completedFuture() {
  final completer = Completer<void>()..complete();
  return completer.future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NoSqlHive Tests', () {
    late Directory tempDir;
    late FakePathProviderPlatform fakePathProvider;

    setUp(() async {
      // Create a temporary directory for testing.
      tempDir = await Directory.systemTemp.createTemp('nosql_hive_test');
      fakePathProvider = FakePathProviderPlatform(tempDir.path);
      // Override the default path provider.
      PathProviderPlatform.instance = fakePathProvider;
    });

    tearDown(() async {
      // Clean up Hive boxes.
      await Hive.close();
      // Delete the temporary directory if it exists.
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
      resetForTesting();
    });

    test(
      'init initializes Hive with correct path and enforces single initialization',
      () async {
        const noSqlHive = NoSqlHive;
        // First initialization should succeed.
        await noSqlHive.init(dirName: 'nosqldb_test');
        // Calling init again with the same directory should succeed.
        await noSqlHive.init(dirName: 'nosqldb_test');
        // Calling init with a different directory should throw an exception.
        expect(() => noSqlHive.init(dirName: 'other_dir'), throwsException);
      },
    );

    test('deleteFromDevice deletes Hive data and directory', () async {
      const noSqlHive = NoSqlHive;
      await noSqlHive.init(dirName: 'nosqldb_test');

      // Create a dummy Hive box and add some data.
      final box = await Hive.openBox<String>('dummyBox');
      await box.put('key', 'value');
      expect(box.get('key'), equals('value'));

      // Delete data from device.
      final result = await noSqlHive.deleteFromDevice();
      expect(result, isTrue);

      // Verify that the directory has been deleted.
      final fullPath = P.join(tempDir.path, 'nosqldb_test');
      final directory = Directory(fullPath);
      expect(await directory.exists(), isFalse);
    });

    test('openBox opens a box and performs basic operations', () async {
      const noSqlHive = NoSqlHive;
      await noSqlHive.init(dirName: 'nosqldb_test');

      // Open a box using the NoSqlHive wrapper.
      final boxWrapper = await noSqlHive.openBox<int>('testBox');
      expect(boxWrapper, isNotNull);

      // Use the box to store and retrieve data.
      await boxWrapper!.put('number', 42);
      final value = await boxWrapper.get('number');
      expect(value, equals(42));
    });
  });

  //MARK: Box Tests
  group('NoSqlHiveBox Integration Tests', () {
    late Directory tempDir;
    late Box<String> hiveBox;
    late NoSqlHiveBox<String> noSqlHiveBox;

    setUp(() async {
      // Create a temporary directory for testing.
      tempDir = await Directory.systemTemp.createTemp('nosql_hive_test');
      // Initialize Hive with the temporary directory.
      Hive.init(tempDir.path);
      // Open a test box for String values.
      hiveBox = await Hive.openBox<String>('testBox');
      // Create the NoSqlHiveBox using the opened Hive box.
      noSqlHiveBox = NoSqlHiveBox<String>(hiveBox);
    });

    tearDown(() async {
      // Close all Hive boxes.
      await Hive.close();
      // Delete the temporary directory.
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
      // Reset Hive for future tests.
      resetForTesting();
    });

    test('put returns true and get retrieves the value', () async {
      const key = 'key1';
      const value = 'value1';

      // Use the NoSqlHiveBox to put a value.
      final putResult = await noSqlHiveBox.put(key, value);
      expect(putResult, isTrue);

      // Retrieve the value using get. Note that get is synchronous.
      final getResult = noSqlHiveBox.get(key);
      expect(getResult, equals(value));
    });

    test('get returns default value when key is not present', () {
      const key = 'nonExistent';
      const defaultValue = 'default';

      // Since the key does not exist, get should return the default value.
      final result = noSqlHiveBox.get(key, defaultValue: defaultValue);
      expect(result, equals(defaultValue));
    });

    test('get returns null if an error occurs', () async {
      // Simulate an error by closing the underlying Hive box.
      await hiveBox.close();
      // Calling get now should catch the exception and return null.
      final result = noSqlHiveBox.get('anyKey');
      expect(result, isNull);
    });
  });

  group('NoSqlHiveBox close() Tests', () {
    late Directory tempDir;
    late Box<String> hiveBox;
    late NoSqlHiveBox<String> noSqlHiveBox;

    setUp(() async {
      // Create a temporary directory and initialize Hive.
      tempDir = await Directory.systemTemp.createTemp('nosql_hive_close_test');
      Hive.init(tempDir.path);
      hiveBox = await Hive.openBox<String>('testBox');
      noSqlHiveBox = NoSqlHiveBox<String>(hiveBox);
    });

    tearDown(() async {
      // Wrap Hive.close() in try-catch to avoid PathNotFoundException.
      try {
        await Hive.close();
      } on Object catch (_) {
        // Ignore errors related to missing files.
      }
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
      resetForTesting();
    });

    test('close() properly closes the box', () async {
      // Ensure the box is open before closing.
      expect(hiveBox.isOpen, isTrue);
      // Call close on the NoSqlHiveBox.
      noSqlHiveBox.close();
      // Verify that the underlying Hive box is closed.
      expect(hiveBox.isOpen, isFalse);
    });
  });
}
