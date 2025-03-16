import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

part 'clock_painter.dart';

const double _defaultRadius = 50;
const double _minimumRadius = 30;
const double _tickStroke = 1.1;
const _fontMultipler = 0.24;
const _hourOffsetMultipler = 0.15;

class AnalogClock extends StatefulWidget {
  const AnalogClock({
    super.key,
    this.utcMinuteOffset,
    this.radius = _defaultRadius,
    this.faceColor,
    this.borderColor,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
  }) : assert(
         radius >= _minimumRadius,
         'radius must be greater than or equal to 30px',
       );

  final Color? borderColor;
  final Color? faceColor;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final double radius;
  final int? utcMinuteOffset;

  @override
  State<AnalogClock> createState() => _AnalogClock();
}

class _AnalogClock extends ObservingStatefulWidget<AnalogClock> {
  Color borderColor = Colors.black;
  Color faceColor = Colors.white;
  Color hourColor = Colors.black;
  Color minuteColor = Colors.black;
  Color secondColor = Colors.black;
  late final DateTime initalDateTime;
  late final int utcMinuteOffset;

  @override
  void initState() {
    super.initState();
    utcMinuteOffset =
        widget.utcMinuteOffset ?? DateTime.now().timeZoneOffset.inMinutes;
    initalDateTime = DateTime.now().toUtc().add(
      Duration(hours: utcMinuteOffset),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    faceColor = widget.faceColor ?? Theme.of(context).colorScheme.primaryFixed;
    borderColor = widget.borderColor ?? Theme.of(context).colorScheme.secondary;
    hourColor = widget.hourHandColor ?? Theme.of(context).colorScheme.secondary;
    minuteColor = widget.minuteHandColor ?? hourColor;
    secondColor = widget.secondHandColor ?? hourColor;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1), (_) {
        return DateTime.now().toUtc().add(Duration(minutes: utcMinuteOffset));
      }),
      initialData: DateTime.now().toUtc().add(
        Duration(minutes: utcMinuteOffset),
      ),
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        return Container(
          height: widget.radius * 2,
          width: widget.radius * 2,
          decoration: BoxDecoration(
            color: faceColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: _tickStroke),
          ),
          child: CustomPaint(
            painter: _ClockPainter(
              dateTime: snapshot.data ?? initalDateTime,
              faceColor: faceColor,
              tickColor:
                  widget.radius < _defaultRadius
                      ? Colors.transparent
                      : borderColor,
              hourColor: hourColor,
              minuteColor: minuteColor,
              secondColor: secondColor,
              numberStyle: TextStyle(
                fontSize: widget.radius * _fontMultipler,
                color: hourColor,
              ),
              borderColor: borderColor,
              faceNumberOffset: widget.radius * _hourOffsetMultipler,
              tickStroke: _tickStroke,
            ),
          ).withPaddingAll(4),
        );
      },
    );
  }
}
