import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class CubicCurve extends Cubic {
  const CubicCurve(super.a, super.b, super.c, super.d);

  static const _defaultFriction = 500;

  factory CubicCurve.easeIn({int friction = _defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve(0.92 - (friction / 1000), 0.0, 1.0, 1.0);
  }

  factory CubicCurve.easeInOut({int friction = _defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve(
        0.92 - (friction / 1000), 0.0, 0.08 + (friction / 1000), 1.0);
  }

  factory CubicCurve.easeOut({int friction = _defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve(0.0, 0.0, 0.08 + (friction / 1000), 1.0);
  }

  static void _checkFrictionValidate(int friction) {
    assert(friction > 0 && friction < 1000, 'friction must be in (0,1000]');
  }
}

class BounceCurve extends Curve {
  const BounceCurve({this.friction = 200, this.frequency = 300})
      : assert(
            frequency > 0 && frequency < 1000, 'frequency must be in (0,1000]'),
        assert(friction > 0 && friction < 1000, 'friction must be in (0,1000]');

  final int friction;
  final int frequency;

  @override
  double transformInternal(double t) {
    final double realFrequency = math.max(1, frequency / 20);
    final num realFriction = math.pow(20, friction / 100);
    final double at = math.pow(realFriction / 10, -t) * (1 - t);
    const double b = -math.pi / 2;
    final angle = realFrequency * t + b;
    return at * math.cos(angle);
  }
}

class SpringCurve extends Curve {
  final int frequency;
  final int friction;
  final int anticipationSize;
  final int anticipationStrength;

  const SpringCurve(
      {this.frequency = 300,
      this.friction = 200,
      this.anticipationSize = 0,
      this.anticipationStrength = 0})
      : assert(
            frequency > 0 && frequency < 1000, 'frequency must be in (0,100]'),
        assert(friction > 0 && friction < 1000, 'friction must be in (0,100]'),
        assert(anticipationSize >= 0 && anticipationSize < 1000,
            'anticipationSize must be in [0,100]'),
        assert(anticipationStrength >= 0 && anticipationStrength < 1000,
            'anticipationStrength must be in [0,100]');

  @override
  double transformInternal(double t) {
    final double realFrequency = math.max(1, frequency / 20);
    final num realFriction = math.pow(20, friction / 100);
    final double s = anticipationSize / 1000;

    final double frictionT = (t / (1 - s)) - (s / (1 - s));
    final double b;
    final double a;
    final double at;
    if (t < s) {
      final double yS = (s / (1 - s)) - (s / (1 - s));
      final double y0 = (0 / (1 - s)) - (s / (1 - s));
      b = math.acos(1 / getAt1(t: yS, s: s));
      a = (math.acos(1 / getAt1(t: y0, s: s)) - b) / (frequency * (-s));
      at = getAt1(s: s, t: frictionT);
    } else {
      b = 0;
      a = 1;
      at = getAt2(t: frictionT, friction: realFriction);
    }
    final double angle = realFrequency * (t - s) * a + b;
    return 1 - (at * math.cos(angle));
  }

  double getAt1({required double t, required double s}) {
    const double M = 0.8;
    final double x0 = (s / (1 - s));
    const double x1 = 0;
    final double b = (x0 - (M * x1)) / (x0 - x1);
    final double a = (M - b) / x0;
    return (a * t * anticipationStrength / 100) + b;
  }

  double getAt2({required double t, required friction}) {
    return math.pow(friction / 10, -t) * (1 - t);
  }
}
