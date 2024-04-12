part of 'code_preview.dart';

class GravityCodePreview extends CodePreview<GravityCurve> {
  const GravityCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() {
    return 'GravityCurve';
  }

  @override
  List<String> getCurveOptionsText() {
    return [
      if (curve.bounciness > 0) 'bounciness: ${curve.bounciness}',
      if (curve.elasticity > 0) 'elasticity: ${curve.elasticity}',
    ];
  }
}

class ForceWithGravityCodePreview extends CodePreview<ForceWithGravityCurve> {
  const ForceWithGravityCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() {
    return 'ForceWithGravityCurve';
  }

  @override
  List<String> getCurveOptionsText() {
    return [
      if (curve.bounciness > 0) 'bounciness: ${curve.bounciness}',
      if (curve.elasticity > 0) 'elasticity: ${curve.elasticity}',
    ];
  }
}