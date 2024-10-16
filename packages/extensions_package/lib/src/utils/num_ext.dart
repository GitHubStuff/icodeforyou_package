import 'dart:math';

extension DoubleExt on double {
  double get pct => this / 100.0;
  double roundTo(int? places) {
    final mod = pow(10.0, places ?? 2);
    // ignore: unnecessary_parenthesis
    return ((this * mod).round().toDouble() / mod);
  }
}

extension IntExt on int {
  double get pct => toDouble() / 100.0;
}
