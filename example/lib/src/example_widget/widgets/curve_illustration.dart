import 'dart:ui';
import 'package:flutter/material.dart';

class CurveIllustration<T extends Curve> extends StatelessWidget {
  const CurveIllustration(this.curve, {super.key});

  final T curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 200,
      color: const Color(0xf5f5f5f5),
      alignment: Alignment.center,
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: 100,
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
          ..color = Colors.blue
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
    return curve !=oldDelegate.curve;
  }
}
