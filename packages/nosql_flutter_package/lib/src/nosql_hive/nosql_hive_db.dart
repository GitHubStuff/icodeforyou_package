// ignore_for_file: avoid_slow_async_io

import 'dart:async' show FutureOr;
import 'dart:io' show Directory;

import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:nosql_flutter_package/src/nosql_abstract/nosql_abstract.dart'
    show NoSqlBox;
import 'package:nosql_flutter_package/src/nosql_abstract/nosql_db.dart'
    show NoSqlDB;
import 'package:nosql_flutter_package/src/nosql_hive/nosql_hive.dart'
    show NoSqlHiveBox;
// ignore: library_prefixes
import 'package:path/path.dart' as P;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

// ignore: constant_identifier_names
const NoSqlDB NoSqlHive = _NoSqlHive();

@visibleForTesting
void resetForTesting() => _NoSqlHive._fullPath = null;

class _NoSqlHive implements NoSqlDB {
  const _NoSqlHive();

  static String? _fullPath;

  Future<void> _deleteDirectory() async {
    if (kIsWeb) return;
    if (_fullPath == null) {
      throw Exception('Full path not initialized. Call initPath() first.');
    }
    final directory = Directory(_fullPath!);
    final exists = await directory.exists();
    if (exists) {
      await directory.delete(recursive: true);
    }
  }

  Future<String> _getFullPath(String dirPath) async {
    if (P.isAbsolute(dirPath)) {
      // dirPath is already an absolute path, return it as-is.
      return dirPath;
    } else {
      // ignore: omit_local_variable_types
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      // Join the documents directory path with the relative path.
      return P.join(documentsDir.path, dirPath);
    }
  }

  @override
  FutureOr<void> init({String dirName = 'nosqldb'}) async {
    if (kIsWeb) return await Hive.initFlutter();
    final fullPath = await _getFullPath(dirName);

    _fullPath ??= fullPath;
    if (_fullPath != fullPath) {
      throw Exception('NoSqlHive has already been initialized with $_fullPath');
    }
    Hive.init(_fullPath);
  }

  @override
  FutureOr<bool> deleteFromDevice() async {
    try {
      await Hive.deleteFromDisk();
      if (!kIsWeb) await _deleteDirectory();
      _fullPath = null;
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  FutureOr<NoSqlBox<T>?> openBox<T>(String boxName) async {
    final box = await Hive.openBox<T>(boxName);
    return NoSqlHiveBox<T>(box);
  }
}
