// Improves readability
// ignore_for_file: omit_local_variable_types

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart'
    show NoSqlBox, NoSqlDB;

part 'theme_state.dart';

const String _containerName = 'theme202409011448';

class ThemeCubit<T extends NoSqlDB> extends Cubit<ThemeState> {
  ThemeCubit({required T nosqlDB}) : _db = nosqlDB, super(ThemeState.initial) {
    _setup();
  }

  final T _db;
  late final NoSqlBox<String> _box;

  Future<void> _setup() async {
    //final databaseSet = await _db.init();

    final box = await _db.openBox<String>(_containerName);
    assert(box != null, 'Invalid state for NoSqlBox');
    _box = box!;

    final saveThemed = await _box.get(
      _containerName,
      defaultValue: ThemeMode.system.name,
    );
    emit(ThemeState.from(name: saveThemed!));
  }

  Brightness get brightness => state.brightness;

  void setTheme(ThemeMode mode) {
    _box.put(_containerName, mode.name);
    emit(ThemeState.from(name: mode.name));
  }
}
