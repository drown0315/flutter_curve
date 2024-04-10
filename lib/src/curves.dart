import 'dart:math' as math;

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class CubicCurve extends Cubic {
  const CubicCurve._(super.a, super.b, super.c, super.d);

  static const defaultFriction = 500;

  /// A cubic animation curve that starts slowly and ends quickly.
  ///
  /// {@animation 464 192 https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_in.mp4}
  factory CubicCurve.easeIn({int friction = defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve._(0.92 - (friction / 1000), 0.0, 1.0, 1.0);
  }

  /// A cubic animation curve that starts slowly, speeds up, and then ends
  /// slowly.
  ///
  /// {@animation 464 192 https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_in_out.mp4}
  factory CubicCurve.easeInOut({int friction = defaultFriction}) {
    _checkFrictionValidate(friction);
    return CubicCurve._(
        0.92 - (friction / 1000), 0.0, 0.08 + (friction / 1000), 1.0);
  }

  /// A cubic animation curve that starts quickly and ends slowly.
  ///
  /// {@animation 464 192 https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_out.mp4}
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

/// The Spring curve that follows Hooke's law.
///
/// Use [SpringCurve] in place of any curve.
///
/// Basic Spring Curve: only tension and friction. these parameters are equivalent
/// to the parameters in design tools such as `Principle` and `ProtoPie`.
/// e.g.
/// ```dart
///  SpringCurve(tension: 300, friction: 200);
/// ```
///
/// Advanced Spring Curve: damping, stiffness, mass, velocity.
/// if you want to use more advanced parameters, use [SpringCurve.advance].
class SpringCurve extends Curve {
  SpringCurve._(
      {required this.damping,
      required this.stiffness,
      required this.mass,
      required this.velocity});

  final double damping;
  final double stiffness;
  final double mass;
  final double velocity;

  late final SpringSimulation _springSimulation = SpringSimulation(
      SpringDescription(mass: mass, stiffness: stiffness, damping: damping),
      0.0,
      1.0,
      velocity);

  static const double initialDamping = 15;
  static const double initialStiffness = 300;
  static const double initialVelocity = 0.0;
  static const double initialMass = 1.0;
  static const double initialFriction = initialDamping;
  static const double initialTension = initialStiffness;

  double get friction => damping;

  double get tension => stiffness;

  /// Provides basic spring curve.
  /// If you use design tools like `Principle` or `ProtoPie`, recommend using this constructor.
  /// these parameters are equivalent to the parameters in the software design.
  factory SpringCurve(
      {double friction = initialFriction, double tension = initialTension}) {
    return SpringCurve._(
        mass: initialMass,
        stiffness: tension,
        damping: friction,
        velocity: initialVelocity);
  }

  /// Advanced Spring Curve: damping, stiffness, mass, velocity.
  /// if you want to use more advanced parameters, use [SpringCurve.advance].
  /// if you use design tools like `Framer`, recommend using this constructor.
  factory SpringCurve.advance({
    double damping = initialDamping,
    double stiffness = initialStiffness,
    double mass = initialMass,
    double velocity = initialVelocity,
  }) {
    return SpringCurve._(
      damping: damping,
      stiffness: stiffness,
      mass: mass,
      velocity: velocity,
    );
  }

  @override
  double transformInternal(double t) {
    return _springSimulation.x(t) + t * (1 - _springSimulation.x(1));
  }

  SpringCurve copyWith({
    double? friction,
    double? tension,
  }) {
    return SpringCurve(
      friction: friction ?? this.friction,
      tension: tension ?? this.tension,
    );
  }

  SpringCurve copyWithAdvance({
    double? damping,
    double? stiffness,
    double? mass,
    double? velocity,
  }) {
    return SpringCurve.advance(
      damping: damping ?? this.damping,
      stiffness: stiffness ?? this.stiffness,
      mass: mass ?? this.mass,
      velocity: velocity ?? this.velocity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpringCurve &&
          runtimeType == other.runtimeType &&
          damping == other.damping &&
          stiffness == other.stiffness &&
          mass == other.mass &&
          velocity == other.velocity;

  @override
  int get hashCode =>
      damping.hashCode ^ stiffness.hashCode ^ mass.hashCode ^ velocity.hashCode;

  @override
  String toString() {
    return 'SpringCurve{damping: $damping, stiffness: $stiffness, mass: $mass, velocity: $velocity}';
  }
}

class GravityCurve extends Curve {
  const GravityCurve(
      {this.bounciness = 400,
      this.elasticity = 200,
      this.returnToInitial = false})
      : assert(bounciness > 0 && bounciness <= 1000,
            'bounciness must be in (0,1000]'),
        assert(elasticity > 0 && elasticity <= 1000,
            'elasticity must be in (0,1000]');

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
