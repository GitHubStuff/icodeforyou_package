part of 'analog_clock.dart';

class _ClockPainter extends CustomPainter {
  _ClockPainter({
    required this.dateTime,
    required this.faceColor,
    required this.tickColor,
    required this.hourColor,
    required this.minuteColor,
    required this.secondColor,
    required this.borderColor,
    required this.numberStyle,
    required this.faceNumberOffset,
    required this.tickStroke,
  });

  final DateTime dateTime;
  final Color faceColor;
  final Color tickColor;
  final Color hourColor;
  final Color minuteColor;
  final Color? secondColor;
  final Color borderColor;
  final TextStyle? numberStyle;
  final double? faceNumberOffset;
  final double tickStroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = radius / 20;
    final shortTickLength = radius * .025;
    final longTickLength = radius * .05;

    // Apply a delta to extend the ticks fully to the edge
    final tickDelta = 4 + tickStroke;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw the hour and minute ticks
    for (var i = 0; i < 60; i++) {
      final tickLength = i % 5 == 0 ? longTickLength : shortTickLength;

      // Apply delta to ensure tick reaches the edge
      final tickStart = Offset(
        center.dx +
            (radius + tickDelta) *
                cos(i * pi / 30), // Extend tick start slightly outward
        center.dy + (radius + tickDelta) * sin(i * pi / 30),
      );
      final tickEndPosition = Offset(
        center.dx + (radius - tickLength) * cos(i * pi / 30),
        center.dy + (radius - tickLength) * sin(i * pi / 30),
      );

      // Draw the tick
      canvas.drawLine(
        tickStart,
        tickEndPosition,
        Paint()
          ..color = tickColor
          ..strokeWidth = tickStroke,
      );

      // Draw hour numbers at every fifth tick
      if (numberStyle != null && i % 5 == 0) {
        final numberRadius = radius - (faceNumberOffset ?? 0);
        final numberPosition = Offset(
          center.dx + numberRadius * cos((i - 15) * pi / 30),
          center.dy + numberRadius * sin((i - 15) * pi / 30),
        );

        textPainter
          ..text = TextSpan(
            text: '${i ~/ 5 == 0 ? 12 : i ~/ 5}',
            style: numberStyle,
          )
          ..layout()
          ..paint(
            canvas,
            numberPosition -
                Offset(textPainter.width / 2, textPainter.height / 2),
          );
      }
    }

    // Draw the hour hand
    final hourHandAngle = dateTime.hour * pi / 6 + dateTime.minute * pi / 360;
    final hourHandLength = radius / 2;
    final hourHandPosition = Offset(
      center.dx + hourHandLength * cos(hourHandAngle - pi / 2),
      center.dy + hourHandLength * sin(hourHandAngle - pi / 2),
    );

    canvas.drawLine(
      center,
      hourHandPosition,
      Paint()
        ..color = hourColor
        ..strokeWidth = strokeWidth / 2,
    );

    // Draw the minute hand
    final minuteSweep =
        (radius < _minimumRadius) ? 0 : (dateTime.second / 60 - 0.16);
    final minuteHandAngle = (dateTime.minute + minuteSweep) * pi / 30;
    final minuteHandLength = radius * 3 / 4;
    final minuteHandPosition = Offset(
      center.dx + minuteHandLength * cos(minuteHandAngle - pi / 2),
      center.dy + minuteHandLength * sin(minuteHandAngle - pi / 2),
    );

    canvas.drawLine(
      center,
      minuteHandPosition,
      Paint()
        ..color = minuteColor
        ..strokeWidth = strokeWidth / 2,
    );

    // Draw the second hand (if present)
    if (secondColor != null) {
      final secondHandAngle = dateTime.second * pi / 30;
      final secondHandLength = radius * 4 / 5;
      final secondHandPosition = Offset(
        center.dx + secondHandLength * cos(secondHandAngle - pi / 2),
        center.dy + secondHandLength * sin(secondHandAngle - pi / 2),
      );

      canvas.drawLine(
        center,
        secondHandPosition,
        Paint()
          ..color = secondColor!
          ..strokeWidth = strokeWidth / 3,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
