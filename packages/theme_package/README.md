# THEME PACKAGE

## Features

Persist theme across app launches and has support for a splash screen.

## Getting started

- add to pubspec.yaml
  
```yaml
dependencies:
  extensions_package:
    git: https://github.com/GitHubStuff/extensions_package.git
```

## Usage

- See **/example** for example of usage - but basically:

```dart
void main() {
  runApp(
    ThemeApp(
      fadeDuration: const Duration(milliseconds: 500),
      parentScreen: const ExampleHomeScreen(title: 'Example Home Page'),
      splashDuration: const Duration(milliseconds: 300),
      splashScreen: Image.asset('assets/images/demo1024x1024.png'),

      /// ThemeData? darkTheme,
      /// ThemeData? lightTheme,
    ),
  );
}
```

Make it the first app after ```runApp()```

## Additional information

Uses a NoSql database to store the them preference. It takes only a few milliseconds to setup, so ```SplashScreen``` is a good visual effect to show to cover the setup.

A helper widget ```ThemeSettingWidget``` provides a Card() widget with radio button for the user to set themes:

```dart
class ThemeSettingWidget extends StatelessWidget {
  const ThemeSettingWidget({
    super.key,
    Widget? titleWidget,
    Widget? darkThemeWidget,
    Widget? systemThemeWidget,
    Widget? lightThemeWidget,
  })  : titleWidget = titleWidget ??
            const Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
        darkThemeWidget = darkThemeWidget ?? const Text('Dark'),
        systemThemeWidget = systemThemeWidget ?? const Text('System'),
        lightThemeWidget = lightThemeWidget ?? const Text('Light');
```

To set the theme get access to the ```ThemeCubit``` and use:

```dart
  void setTheme(ThemeMode mode)
```

### Examples

```dart
 context.read<ThemeCubit>().setTheme(ThemeMode.dark);
 context.read<ThemeCubit>().setTheme(ThemeMode.system);
 context.read<ThemeCubit>().setTheme(ThemeMode.light);
```

## Finally

Be kind to each other!
