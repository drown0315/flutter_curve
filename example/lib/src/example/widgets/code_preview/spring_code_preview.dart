part of 'code_preview.dart';

class SpringBasicCodePreview extends CodePreview<SpringCurve> {
  const SpringBasicCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() => 'SpringCurve';

  @override
  List<String> getCurveOptionsText() {
    return [
      'tension: ${curve.tension}',
      'friction: ${curve.friction}',
    ];
  }
}

class SpringAdvanceCodePreview extends CodePreview<SpringCurve> {
  const SpringAdvanceCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() => 'SpringCurve.advance';

  @override
  List<String> getCurveOptionsText() {
    return [
      'damping: ${curve.damping}',
      'stiffness: ${curve.stiffness}',
      'mass: ${curve.mass}',
      'velocity: ${curve.velocity}',
    ];
  }
}
