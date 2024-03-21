import 'dart:ui';
import 'package:flutter/material.dart';

/// Animated Curve line chart.
class CurveIllustration<T extends Curve> extends StatelessWidget {
  const CurveIllustration(
    this.curve, {
    super.key,
    required this.width,
    required this.height,
  });

  final T curve;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xf5f5f5f5),
      alignment: Alignment.center,
      child: SizedBox(
          width: width,
          height: height / 2,
          child: CustomPaint(
            painter: CurvePainter(curve),
          )),
    );
  }
}

class CurvePainter extends CustomPainter {
  final Curve curve;

  CurvePainter(this.curve) : super();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(0, size.height),
        Offset(size.width, size.height),
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 0.5);

    canvas.drawLine(
        Offset.zero,
        Offset(size.width, 0),
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 0.5);

    _drawCurve(size, canvas);
    _drawYValue(size, canvas);
  }

  void _drawCurve(Size size, Canvas canvas) {
    final double percent = 1 / size.width;
    final List<Offset> points = [];
    for (int i = 0; i < size.width; i++) {
      final double y = size.height * curve.transform(percent * i);
      points.add(Offset(i.toDouble(), -y + size.height));
    }
    canvas.drawPoints(
        PointMode.polygon,
        points,
        Paint()
          ..color = Colors.blueAccent
          ..strokeWidth = 2);
  }

  /// Draw 0 and 1 in y axis.
  void _drawYValue(Size size, Canvas canvas) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    // draw 0.
    final yValuePainter = TextPainter(
      text: const TextSpan(
        text: '0',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    yValuePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    yValuePainter.paint(canvas, Offset(0, size.height - 20));

    // draw 1.
    yValuePainter.text = const TextSpan(
      text: '1',
      style: textStyle,
    );
    yValuePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    yValuePainter.paint(canvas, const Offset(0, 0 - 20));
  }

  @override
  bool shouldRepaint(covariant CurvePainter oldDelegate) {
    return curve != oldDelegate.curve;
  }
}
