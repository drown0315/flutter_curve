import 'package:flutter/material.dart';

class AnimationExample extends StatefulWidget {
  const AnimationExample(
      {super.key, required this.curve, required this.duration});

  final Curve curve;
  final Duration duration;

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  final double _movingCircleRadius = 15;
  final double _guideLineCircleRadius = 5;

  @override
  Widget build(BuildContext context) {
    final maxMoveValue =
        MediaQuery.sizeOf(context).width * 0.8 - _movingCircleRadius * 2;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 30,
      alignment: Alignment.center,
      child: Stack(
        children: [
          /// Guide line.
          Positioned(
              left: _movingCircleRadius - _guideLineCircleRadius,
              right: _movingCircleRadius - _guideLineCircleRadius,
              top: 0,
              bottom: 0,
              child: CustomPaint(
                painter: GuideLinePainter(circleRadius: _guideLineCircleRadius),
              )),

          /// Moving Circle.
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildAnimationCircle(lineWidth: maxMoveValue),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationCircle({required double lineWidth}) {
    return _CircleMoveAnimation(
        curve: widget.curve,
        duration: widget.duration,
        maxMoveValue: lineWidth,
        child: Container(
          width: _movingCircleRadius * 2,
          height: _movingCircleRadius * 2,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ));
  }
}

class _CircleMoveAnimation extends StatefulWidget {
  const _CircleMoveAnimation(
      {required this.curve,
      required this.duration,
      required this.child,
      required this.maxMoveValue});

  final Curve curve;

  final Duration duration;

  final double maxMoveValue;

  final Widget child;

  @override
  State<_CircleMoveAnimation> createState() => _CircleMoveAnimationState();
}

class _CircleMoveAnimationState extends State<_CircleMoveAnimation>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = widget.curve.transform(_controller.value);
        final x = value * widget.maxMoveValue;
        return Transform.translate(
          offset: Offset(x, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant _CircleMoveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.curve != widget.curve ||
        oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.reset();
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GuideLinePainter extends CustomPainter {
  GuideLinePainter({super.repaint, required this.circleRadius});

  final double circleRadius;

  @override
  void paint(Canvas canvas, Size size) {
    _drawGuideLine(size, canvas);
    _drawCircle(size, canvas);
    _drawPointValue(size, canvas);
  }

  void _drawGuideLine(Size size, Canvas canvas) {
    canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 0.5);
  }

  void _drawCircle(Size size, Canvas canvas) {
    canvas.drawCircle(
        Offset(circleRadius, size.height / 2),
        circleRadius,
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 0.5);
    canvas.drawCircle(
        Offset(size.width - circleRadius, size.height / 2),
        circleRadius,
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 0.5);
  }

  /// Draw 0 and 1 in y axis.
  void _drawPointValue(Size size, Canvas canvas) {
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

    yValuePainter.paint(
        canvas, Offset(0 + circleRadius / 2, size.height / 2 + 20));

    // draw 1.
    yValuePainter.text = const TextSpan(
      text: '1',
      style: textStyle,
    );
    yValuePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    yValuePainter.paint(
        canvas, Offset(size.width - circleRadius, size.height / 2 + 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
