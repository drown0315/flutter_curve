part of 'code_preview.dart';

class SpringCodePreview extends CodePreview<SpringCurve> {
  const SpringCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() => 'SpringCurve';

  @override
  List<String> getCurveOptionsText() {
    return [
      if (curve.frequency > 0) 'frequency: ${curve.frequency}',
      if (curve.friction > 0) 'friction: ${curve.friction}',
      if (curve.anticipationSize > 0)
        'anticipationSize: ${curve.anticipationSize}',
      if (curve.anticipationStrength > 0)
        'anticipationStrength: ${curve.anticipationStrength}',
    ];
  }
}
