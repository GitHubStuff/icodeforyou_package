import 'dart:ui';

class ColorPair {
  ColorPair({required this.dark, required this.light});
  final Color dark;
  final Color light;

  Color color() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    return brightness == Brightness.dark ? dark : light;
  }
}
