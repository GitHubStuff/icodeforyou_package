import 'dart:ui';

enum AppThemeMode {
  system,
  light,
  dark;

  /// Returns an [AppThemeMode] based on the provided string.
  /// The string is matched case-insensitively.
  /// Throws an [ArgumentError] if the string does not match any valid mode.
  static AppThemeMode fromString(String value) {
    switch (value.toLowerCase()) {
      case 'system':
        return AppThemeMode.system;
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        throw ArgumentError('Invalid AppThemeMode: $value');
    }
  }

  /// Returns the corresponding [Brightness] for the theme mode.
  Brightness toBrightness() {
    switch (this) {
      case AppThemeMode.light:
        return Brightness.light;
      case AppThemeMode.dark:
        return Brightness.dark;
      case AppThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness;
    }
  }
}
