import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class CubicCurve extends Cubic {
  const CubicCurve._(super.a, super.b, super.c, super.d);

  static const defaultFriction = 500;

  factory CubicCurve.easeIn({int friction = defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve._(0.92 - (friction / 1000), 0.0, 1.0, 1.0);
  }

  factory CubicCurve.easeInOut({int friction = defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve._(
        0.92 - (friction / 1000), 0.0, 0.08 + (friction / 1000), 1.0);
  }

  factory CubicCurve.easeOut({int friction = defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve._(0.0, 0.0, 0.08 + (friction / 1000), 1.0);
  }

  static void _checkFrictionValidate(int friction) {
    assert(friction > 0 && friction <= 1000, 'friction must be in (0,1000]');
  }
}

class BounceCurve extends Curve {
  const BounceCurve({this.friction = 200, this.frequency = 300})
      : assert(frequency > 0 && frequency <= 1000,
            'frequency must be in (0,1000]'),
        assert(
            friction > 0 && friction <= 1000, 'friction must be in (0,1000]');

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

  BounceCurve copyWith({int? friction, int? frequency}) {
    return BounceCurve(
      friction: friction ?? this.friction,
      frequency: frequency ?? this.frequency,
    );
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
            frequency > 0 && frequency <= 1000, 'frequency must be in (0,100]'),
        assert(friction > 0 && friction <= 1000, 'friction must be in (0,100]'),
        assert(anticipationSize >= 0 && anticipationSize <= 1000,
            'anticipationSize must be in [0,100]'),
        assert(anticipationStrength >= 0 && anticipationStrength <= 1000,
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

  SpringCurve copyWith(
      {int? frequency,
      int? friction,
      int? anticipationSize,
      int? anticipationStrength}) {
    return SpringCurve(
        frequency: frequency ?? this.frequency,
        friction: friction ?? this.friction,
        anticipationSize: anticipationSize ?? this.anticipationSize,
        anticipationStrength:
            anticipationStrength ?? this.anticipationStrength);
  }

  @override
  String toString() {
    return 'SpringCurve{frequency: $frequency, friction: $friction, anticipationSize: $anticipationSize, anticipationStrength: $anticipationStrength}';
  }
}

class GravityCurve extends Curve {
  const GravityCurve(
      {this.bounciness = 400,
      this.elasticity = 200,
      this.returnToInitial = false})
      : assert(bounciness > 0 && bounciness <= 1000,
            'bounciness must be in (0,100]'),
        assert(elasticity > 0 && elasticity <= 1000,
            'elasticity must be in (0,100]');

  final int bounciness;
  final int elasticity;
  final bool returnToInitial;
  final double gravity = 100;

  @override
  double transformInternal(double t) {
    final double realBounciness = math.min((bounciness / 1250), 0.8);
    final double realElasticity = elasticity / 1000;
    final double L =
        _calculateCurve(bounciness: realBounciness, elasticity: realElasticity);
    final List<_EasingCurve> curves = _createEasingCurves(
        bounciness: realBounciness, elasticity: realElasticity, L: L);
    int i = 0;
    _EasingCurve? curve = curves[i];
    while (!(t >= curve!.start && t <= curve.end)) {
      i++;
      if (i >= curves.length) {
        curve = null;
        break;
      } else {
        curve = curves[i];
      }
    }
    if (curve == null) {
      return returnToInitial ? 0 : 1;
    } else {
      return _getPointInCurve(curve: curve, t: t);
    }
  }

  double _calculateCurve({
    required double bounciness,
    required double elasticity,
  }) {
    double b = math.sqrt(2 / gravity);
    _EasingCurve curve = _EasingCurve(start: -b, end: b, height: 1);
    if (returnToInitial) {
      curve.start = 0;
      curve.end = curve.end * 2;
    }
    while (curve.height > 0.001) {
      double L = curve.end - curve.start;
      curve = _EasingCurve(
        start: curve.end,
        end: curve.end + L * bounciness,
        height: curve.height * bounciness * bounciness,
      );
    }
    return curve.end;
  }

  List<_EasingCurve> _createEasingCurves(
      {required double bounciness,
      required double elasticity,
      required double L}) {
    final double b = math.sqrt(2 / (gravity * L * L));
    final List<_EasingCurve> curves = [];
    _EasingCurve curve = _EasingCurve(start: -b, end: b, height: 1);
    if (returnToInitial) {
      curve.start = 0;
      curve.end = curve.end * 2;
    }
    curves.add(curve);
    while (curve.end < 1 && curve.height > 0.001) {
      final double l2 = curve.end - curve.start;
      curve = _EasingCurve(
        start: curve.end,
        end: curve.end + l2 * bounciness,
        height: curve.height * elasticity,
      );
      curves.add(curve);
    }
    return curves;
  }

  double _getPointInCurve({required _EasingCurve curve, required double t}) {
    double L = curve.end - curve.start;
    double t2 = (2 / L) * (t) - 1 - (curve.start * 2 / L);
    double c = t2 * t2 * curve.height - curve.height + 1;
    if (returnToInitial) {
      c = 1 - c;
    }
    return c;
  }

  GravityCurve copyWith({
    int? bounciness,
    int? elasticity,
  }) {
    return GravityCurve(
        bounciness: bounciness ?? this.bounciness,
        elasticity: elasticity ?? this.elasticity);
  }
}

class ForceWithGravityCurve extends GravityCurve {
  const ForceWithGravityCurve({super.bounciness = 400, super.elasticity = 200})
      : super(returnToInitial: true);

  @override
  ForceWithGravityCurve copyWith({int? bounciness, int? elasticity}) {
    return ForceWithGravityCurve(
        bounciness: bounciness ?? this.bounciness,
        elasticity: elasticity ?? this.elasticity);
  }
}

class _EasingCurve {
  double start;
  double end;
  double height;

  _EasingCurve({required this.start, required this.end, required this.height});
}
