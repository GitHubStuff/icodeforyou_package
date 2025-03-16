part of 'marquee_cubit.dart';

enum MarqueeDirection { ltr, rtl }

class MarqueeCubitState {
  MarqueeCubitState({
    required this.activeMarqueeKeys,
    this.direction = MarqueeDirection.rtl, // Default to RTL
    this.isOneShot = false, // Default to repeating
  });
  final Set<GlobalKey> activeMarqueeKeys;
  final MarqueeDirection direction;
  final bool isOneShot;
}
