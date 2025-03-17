import 'package:flutter/material.dart'
    show
        Animation,
        BuildContext,
        FadeTransition,
        Offset,
        RotationTransition,
        ScaleTransition,
        SlideTransition,
        Tween,
        Widget;

typedef PageTransitionBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    );

enum SplashTransition {
  fade,
  fadeScale,
  fadeSlide,
  rotate,
  scale,
  slide;

  /// Extension on SplashTransition to provide a PageTransitionBuilder.

  PageTransitionBuilder get builder {
    switch (this) {
      case SplashTransition.fade:
        return (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child);
      case SplashTransition.fadeScale:
        final scaleTween = Tween<double>(begin: 0.2, end: 1);
        return (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: scaleTween.animate(animation),
                child: child,
              ),
            );
      case SplashTransition.slide:
        final offsetTween = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );
        return (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: offsetTween.animate(animation),
              child: child,
            );
      case SplashTransition.scale:
        final scaleTween = Tween<double>(begin: 0.2, end: 1);
        return (context, animation, secondaryAnimation, child) =>
            ScaleTransition(scale: scaleTween.animate(animation), child: child);
      case SplashTransition.rotate:
        // 0.25 turns is 90 degrees
        final rotateTween = Tween<double>(begin: 0.1, end: 0);
        return (context, animation, secondaryAnimation, child) =>
            RotationTransition(
              turns: rotateTween.animate(animation),
              child: child,
            );
      case SplashTransition.fadeSlide:
        final offsetTween = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );
        return (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: offsetTween.animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
    }
  }
}
