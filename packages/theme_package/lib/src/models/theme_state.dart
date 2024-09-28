part of 'theme_cubit.dart';

enum ThemeState {
  dark,
  initial,
  light,
  system;

  static ThemeState from({required String name}) {
    for (final state in ThemeState.values) {
      if (state.name.toLowerCase() == name.toLowerCase()) {
        return state;
      }
    }
    throw Exception('ThemeState not found');
  }

  ThemeMode get mode {
    switch (this) {
      case ThemeState.dark:
        return ThemeMode.dark;
      case ThemeState.light:
        return ThemeMode.light;
      case ThemeState.initial:
      case ThemeState.system:
        return ThemeMode.system;
    }
  }

  Brightness get brightness {
    switch (this) {
      case ThemeState.dark:
        return Brightness.dark;
      case ThemeState.light:
        return Brightness.light;
      case ThemeState.initial:
      case ThemeState.system:
        return PlatformDispatcher.instance.platformBrightness;
    }
  }
}
