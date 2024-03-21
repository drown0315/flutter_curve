import 'package:example/src/example/widgets/code_preview/code_preview.dart';
import 'package:example/src/example/widgets/curve_option/cubic_option.dart';
import 'package:flutter_curve/flutter_curve.dart';

class EaseCodePreview extends CodePreview<CubicCurve> {
   EaseCodePreview(
      {super.key,
      required super.curve,
      required super.width,
      required super.duration});

  @override
  String getCurveName() {
    switch (cubicType) {
      case CubicType.easeIn:
        return 'CubicCurve.easeIn';
      case CubicType.easeOut:
        return 'CubicCurve.easeOut';
      case CubicType.easeInOut:
        return 'CubicCurve.easeInOut';
    }
  }

  final CubicCurve easeIn = CubicCurve.easeIn();
  final CubicCurve easeOut = CubicCurve.easeOut();

  CubicType get cubicType {
    if (curve.c == easeIn.c && curve.d == easeIn.d) {
      return CubicType.easeIn;
    } else if (curve.a == easeOut.a &&
        curve.b == easeOut.b &&
        curve.d == easeOut.d) {
      return CubicType.easeOut;
    } else {
      return CubicType.easeInOut;
    }
  }

  int get friction {
    switch (cubicType) {
      case CubicType.easeIn:
        {
          return (1000 * (0.92 - curve.a)).round();
        }
      case CubicType.easeInOut:
        {
          return (1000 * (0.92 - curve.a)).round();
        }
      case CubicType.easeOut:
        {
          return (1000 * (curve.c - 0.08)).round();
        }
    }
  }

  @override
  List<String> getCurveOptionsText() {
    int friction = this.friction;
    return [
      if (friction > 0) 'friction: $friction',
    ];
  }
}
