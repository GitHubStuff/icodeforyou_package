import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

extension ImageExtension on Image {
  Widget rotate({required double percentage}) => RotationTransition(
    turns: AlwaysStoppedAnimation(percentage),
    child: this,
  );

  /// Attempts to save an image a Uint8List for on-device use or export.
  Future<Uint8List?> asBytes() async {
    final controller = _WidgetPngController();
    _WidgetPngConverter(controller: controller, child: this);
    return controller.capture();
  }
}

class _WidgetPngController {
  GlobalKey containerKey = GlobalKey();

  /// to capture widget to image by GlobalKey in RenderRepaintBoundary
  Future<Uint8List?> capture() async {
    try {
      /// boundary widget by GlobalKey
      final boundary =
          containerKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      /// convert boundary to image
      final image = await boundary!.toImage(pixelRatio: 6);

      /// set ImageByteFormat
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      rethrow;
    }
  }
}

class _WidgetPngConverter extends StatelessWidget {
  const _WidgetPngConverter({required this.child, required this.controller});

  final Widget? child;
  final _WidgetPngController controller;

  @override
  Widget build(BuildContext context) {
    /// to capture widget to image by GlobalKey in RepaintBoundary
    return RepaintBoundary(key: controller.containerKey, child: child);
  }
}
