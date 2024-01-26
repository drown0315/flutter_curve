import 'dart:ui';

import 'package:flutter/material.dart';

class CurveIllustration<T extends Curve> extends StatelessWidget {
  const CurveIllustration(this.curve, {super.key});

  final T curve;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: 100,
        child: CustomPaint(
          painter: CurvePainter(curve),
        ));
  }
}

class CurvePainter extends CustomPainter {
  final Curve curve;

  CurvePainter(this.curve) : super();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset.zero,
        Offset(size.width, 0),
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 2);
    final double percent = 1 / size.width;
    final List<Offset> points = [];
    for (int i = 0; i < size.width; i++) {
      final double y = size.height * curve.transform(percent * i);
      points.add(Offset(i.toDouble(), -y));
    }
    canvas.drawPoints(
        PointMode.polygon,
        points,
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
