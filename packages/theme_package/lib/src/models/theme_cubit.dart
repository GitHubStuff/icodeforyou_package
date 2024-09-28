// ignore_for_file: omit_local_variable_types

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

part 'theme_state.dart';

const String _containerName = 'theme202409011448';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial) {
    _setup();
  }

  final _store = KeyValueStore();

  Future<void> _setup() async {
    final databaseSet = await _store.setUp(containerName: _containerName);
    if (!databaseSet) return;
    final saveThemed = await _store.get<String>(
      key: _containerName,
      defaultValue: ThemeMode.system.name,
    );
    emit(ThemeState.from(name: saveThemed!));
  }

  Brightness get brightness => state.brightness;

  void setTheme(ThemeMode mode) {
    _store.put<String>(key: _containerName, value: mode.name);
    emit(ThemeState.from(name: mode.name));
  }
}
