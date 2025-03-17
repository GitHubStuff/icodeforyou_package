# _template_app_flutter

A new Flutter project.

## Getting Started

### Changes to create unique app

- Find/Replace `_template_app_flutter` to name of the flutter name of the app (ex: `my_spiffy_app`)
- Find/Replace `MyAppName` to a label used for apps on mobile Platforms (ex:`My Spiffy Mobile App`)
- Find/Replace `macOSName` to the name of your macOS app (ex: `My Spiffy macOS App`)
- Find/Replace `my.domain` to the project down for the product/customer (ex: `icodeforyou.com`)
- Find/Replace `reverse.domain` with the projects **reverse domain** that the start of the apps' identifier (ex: `com.icodeforyou`)
- Find/Replace `bundleSuffix` with bundle id (ex: `my_spiffy_app`) **[using the folder name is ideal]**
- Find/Replace `AppleSuffix` for Apple bundles as iOS/MacOS do like '_'. **[ideal is folder name to lower-camel case (ex: `mySpiffyApp`)]**
- The image `/assets/images/ic4u1024x1024.png` is a placeholder image to generate application icons. In the `pubspec.yaml` file is section marked *flutter_icons*:

### Creating Icons

The configuration for the icons in the **pubspec.yaml**

```dart
  flutter_icons:
  android: 'launcher_icon'
  ios: true
  remove_alpha_ios: true
  image_path: 'assets/images/ic4u1024x1024.png'
  macos:
    generate: true
    image_path: 'assets/images/ic4u1024x1024.png'
  web:
    generate: true
    image_path: 'assets/images/ic4u1024x1024.png'
  windows:
    generate: true
    image_path: 'assets/images/ic4u1024x1024.png'
  ```

## POST CHANGE CHECK LIST

From the IDE or terminal do the following

```zsh
dart run flutter_launcher_icons  #creates icons
flutter clean
flutter pub get
dart run build_runner build -d
```

The `build_runner` will generate `lib/gen/assets.gen.dart`, this is part of [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner), the flutter code generator for assets/fonts/colors to get rid of String-based APIs. Search `flutter_gen_runner` for an example of it's use.

All done, this is ideal **first-commit** for the new app.

## Finally

Be kind to each other!
