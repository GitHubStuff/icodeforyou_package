import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:key_value_package/src/src.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStore extends KeyValueAbstract {
  late final Box<dynamic> _box;
  late final SharedPreferencesAsync _prefs;

  @override
  FutureOr<bool> setUp({
    required String containerName,
    String subDir = 'db',
  }) async {
    if (kIsWeb) {
      _prefs = SharedPreferencesAsync();
    } else {
      final path = await getApplicationDocumentsDirectory();
      await Hive.initFlutter('$path/$subDir');
      _box = await Hive.openBox<dynamic>(containerName);
    }
    return true;
  }

  @override
  FutureOr<V?> get<V>({required String key, V? defaultValue}) async {
    Object? result;
    if (kIsWeb) {
      if (V == String) {
        result = await _prefs.getString(key);
      } else if (V == int) {
        result = await _prefs.getInt(key) as V;
      } else if (V == double) {
        result = await _prefs.getDouble(key) as V;
      } else if (V == bool) {
        result = await _prefs.getBool(key) as V;
      } else if (V == List<String>) {
        result = await _prefs.getStringList(key) as V;
      } else {
        throw Exception('Type $V not supported');
      }
    } else {
      result = _box.get(key) as V?;
    }

    if (result == null && defaultValue != null) {
      await put<V>(key: key, value: defaultValue);
    }
    return (result as V?) ?? defaultValue;
  }

  @override
  FutureOr<void> put<V>({required String key, required V value}) async {
    if (kIsWeb) {
      if (V == String) {
        await _prefs.setString(key, value as String);
      } else if (V == int) {
        await _prefs.setInt(key, value as int);
      } else if (V == double) {
        await _prefs.setDouble(key, value as double);
      } else if (V == bool) {
        await _prefs.setBool(key, value as bool);
      } else if (V == List<String>) {
        await _prefs.setStringList(key, value as List<String>);
      } else {
        throw Exception('Type $V not supported');
      }
    } else {
      await _box.put(key, value);
    }
  }
}
