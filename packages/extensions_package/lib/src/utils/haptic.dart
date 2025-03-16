import 'package:flutter/services.dart';

enum Haptic {
  heavyImpact,
  lightImpact,
  mediumImpact,
  none,
  selectionClick,
  selectionVibrate;

  Future<void> get haptic {
    switch (this) {
      case Haptic.heavyImpact:
        return HapticFeedback.heavyImpact();
      case Haptic.lightImpact:
        return HapticFeedback.lightImpact();
      case Haptic.mediumImpact:
        return HapticFeedback.mediumImpact();
      case Haptic.selectionClick:
        return HapticFeedback.selectionClick();
      case Haptic.selectionVibrate:
        return HapticFeedback.vibrate();
      case Haptic.none:
        return Future<void>.value();
    }
  }
}
