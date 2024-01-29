import 'package:example/src/example_widget/widgets/curve_illustration.dart';
import 'package:example/src/example_widget/widgets/curve_option/bounce_option.dart';
import 'package:example/src/example_widget/widgets/curve_option/cubic_option.dart';
import 'package:example/src/example_widget/widgets/curve_option/gravity_option.dart';
import 'package:example/src/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';

import 'animation_example.dart';
import 'curve_option/curve_option.dart';
import 'curve_option/spring_option.dart';

enum CurveType {
  spring,
  bounce,
  forceWithGravity,
  gravity,
  easeInOut,
  easeIn,
  easeOut
}

class CurvePanel extends StatefulWidget {
  const CurvePanel({Key? key, required this.curveType}) : super(key: key);
  final CurveType curveType;

  @override
  State<CurvePanel> createState() => _CurvePanelState();
}

class _CurvePanelState extends State<CurvePanel> {
  late Curve curve;

  Duration duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    switch (widget.curveType) {
      case CurveType.spring:
        curve = const SpringCurve();
        break;
      case CurveType.bounce:
        curve = const BounceCurve();
        break;
      case CurveType.gravity:
        curve = const GravityCurve();
        break;
      case CurveType.forceWithGravity:
        curve = const ForceWithGravityCurve();
        break;
      case CurveType.easeIn:
        curve = CubicCurve.easeIn();
        break;
      case CurveType.easeOut:
        curve = CubicCurve.easeOut();
        break;
      case CurveType.easeInOut:
        curve = CubicCurve.easeInOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CurveOption curveOptionWidget;
    switch (widget.curveType) {
      case CurveType.spring:
        curveOptionWidget = SpringOption(onChanged: _onCurveChanged);
        break;
      case CurveType.bounce:
        curveOptionWidget = BounceOption(onChanged: _onCurveChanged);
        break;
      case CurveType.gravity:
        curveOptionWidget = GravityOption(onChanged: _onCurveChanged);
        break;
      case CurveType.forceWithGravity:
        curveOptionWidget = ForceWithGravityOption(onChanged: _onCurveChanged);
        break;
      case CurveType.easeIn:
        curveOptionWidget = CubicOption(
            cubicType: CubicType.easeIn, onChanged: _onCurveChanged);
        break;
      case CurveType.easeInOut:
        curveOptionWidget = CubicOption(
            cubicType: CubicType.easeInOut, onChanged: _onCurveChanged);
        break;
      case CurveType.easeOut:
        curveOptionWidget = CubicOption(
            cubicType: CubicType.easeOut, onChanged: _onCurveChanged);
        break;
      default:
        curveOptionWidget = BounceOption(onChanged: _onCurveChanged);
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurveIllustration(curve),
        const SizedBox(height: SizeConstant.s),
        curveOptionWidget,
        const SizedBox(height: SizeConstant.s),
        AnimationExample(
          curve: curve,
          key: ValueKey(curve),
          duration: duration,
        ),
      ],
    );
  }

  void _onCurveChanged(Duration duration, Curve curve) {
    setState(() {
      this.curve = curve;
      this.duration = duration;
    });
  }
}
