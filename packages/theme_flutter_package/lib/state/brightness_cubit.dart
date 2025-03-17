import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart' show Brightness;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

const String _brightnessKey = 'BrightnessCubit_box_name';

class BrightnessCubit extends Cubit<Brightness> {
  BrightnessCubit({required NoSqlDB noSqlDb}) : super(Brightness.dark) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged =
        _platformBrightnessChanged;

    _init(noSqlDb);
  }

  late final NoSqlBox<String> _box;
  late AppThemeMode _appThemeMode;

  AppThemeMode get appThemeMode => _appThemeMode;

  @override
  Future<void> close() {
    // Unregister the brightness change callback to avoid memory leaks.
    PlatformDispatcher.instance.onPlatformBrightnessChanged = null;
    _box.close();
    return super.close();
  }

  Future<void> _init(NoSqlDB noSqlDb) async {
    _box =
        await noSqlDb.openBox<String>(_brightnessKey) ??
        (throw Exception('Failed to open box $_brightnessKey'));

    final brightness =
        await _box.get(
          _brightnessKey,
          defaultValue: AppThemeMode.system.name,
        ) ??
        (throw Exception('Failed to read box: $_brightnessKey'));
    _appThemeMode = AppThemeMode.fromString(brightness);
    emit(_appThemeMode.toBrightness());
  }

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    _appThemeMode = themeMode;
    await _box.put(_brightnessKey, themeMode.name);
    emit(_appThemeMode.toBrightness());
  }

  void _platformBrightnessChanged() {
    if (_appThemeMode == AppThemeMode.system) {
      emit(AppThemeMode.system.toBrightness());
    }
  }
}
