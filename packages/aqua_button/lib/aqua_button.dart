// Button based on the old-style Aqua Button from macOS-X

import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  const AquaButton({
    required this.materialColor,
    super.key,
    this.radius = 10.0,
  });
  final MaterialColor materialColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final northPoleRadius = radius * 0.85;

    return Container(
      width: radius * 2.0,
      height: radius * 2.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            materialColor,
            materialColor[900]!,
            materialColor[700]!,
            materialColor[500]!,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          // North pole
          Positioned(
            left: radius - northPoleRadius,
            top: -northPoleRadius / 1.3,
            child: Container(
              width: northPoleRadius * 2.0,
              height: northPoleRadius * 2.0,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.55),
                    Colors.transparent,
                  ],
                  stops: [0.09, 0.8],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // South pole
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipOval(
              child: CustomPaint(
                size: Size(radius * 2.0, radius * 2.0),
                painter: _TrianglePainter(mainRadius: radius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.mainRadius});
  final double mainRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final triangleHeight = size.height / 2.5;
    final triangleBase = size.width * 1.0;

    final path =
        Path()
          ..moveTo(size.width / 2.0, size.height - triangleHeight)
          ..lineTo(0, size.height)
          ..lineTo(triangleBase, size.height)
          ..close();

    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(255, 255, 255, 0.1),
        Color.fromRGBO(255, 255, 255, 0.3),
      ],
    );

    final paint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromPoints(
              Offset(0, size.height - triangleHeight),
              Offset(triangleBase, size.height),
            ),
          );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
