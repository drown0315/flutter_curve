part of 'code_preview.dart';

class BounceCodePreview extends CodePreview<BounceCurve> {
  const BounceCodePreview({super.key,
    required super.curve,
    required super.width,
    required super.duration});

  @override
  String getCurveName() => 'BounceCurve';

  @override
  List<String> getCurveOptionsText() {
    return [
      if(curve.frequency > 0)
        'frequency: ${curve.frequency}',
      if(curve.friction > 0)
        'friction: ${curve.friction}',
    ];
  }
}
