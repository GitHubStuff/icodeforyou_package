extension DoubleExt on double {
  double get pct => this / 100.0;
}

extension IntExt on int {
  double get pct => toDouble() / 100.0;
}
