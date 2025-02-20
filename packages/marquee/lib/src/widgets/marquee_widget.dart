// Improves readability
// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class MarqueeWidget extends StatefulWidget {
  const MarqueeWidget({
    required super.key,
    required this.parent,
    required this.child,
    required this.duration,
  });

  final Widget parent;
  final Widget child;
  final Duration duration;

  @override
  ObservingStatefulWidget<MarqueeWidget> createState() => _MarqueeWidget();
}

class _MarqueeWidget extends ObservingStatefulWidget<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  double parentWidth = 0;
  double childWidth = 0;
  late final AnimationController controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    _buildController(widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    final marqueeCubit = context.watch<MarqueeCubit>();
    final isActive = marqueeCubit.state.activeMarqueeKeys.contains(widget.key);
    final direction = marqueeCubit.state.direction;

    if (isActive && animation == null && parentWidth > 0 && childWidth > 0) {
      final double start =
          (direction == MarqueeDirection.rtl) ? parentWidth : -childWidth;
      final double end =
          (direction == MarqueeDirection.rtl) ? -childWidth : parentWidth;
      setState(() {
        animation = Tween<double>(
          begin: start,
          end: end,
        ).animate(controller);

        controller.forward();
      });
    } else if (!isActive && animation != null) {
      setState(() {
        controller.stop();
        animation = null;
      });
    }

    return Stack(
      children: [
        PositionAndSizeWidget(
          onLayout: (size, _) => setState(() => parentWidth = size.width),
          child: widget.parent,
        ),
        Positioned(
          left: animation != null ? animation!.value : parentWidth,
          child: PositionAndSizeWidget(
            onLayout: (size, _) => setState(() => childWidth = size.width),
            child: widget.child,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _buildController(Duration duration) {
    controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            !context.read<MarqueeCubit>().state.isOneShot) {
          controller.repeat();
        }
      })
      ..addListener(() => setState(() {}));
  }
}
