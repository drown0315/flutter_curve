import 'package:example/src/example_widget/widgets/curve_illustration.dart';
import 'package:example/src/example_widget/widgets/curve_option/bounce_option.dart';
import 'package:example/src/example_widget/widgets/curve_option/cubic_option.dart';
import 'package:example/src/example_widget/widgets/curve_option/gravity_option.dart';
import 'package:example/src/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';

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
    final CurveOption curveOption;
    switch (widget.curveType) {
      case CurveType.spring:
        curveOption = SpringOption(onChanged: _onCurveChanged);
        break;
      case CurveType.bounce:
        curveOption = BounceOption(onChanged: _onCurveChanged);
        break;
      case CurveType.gravity:
        curveOption = GravityOption(onChanged: _onCurveChanged);
        break;
      case CurveType.forceWithGravity:
        curveOption = ForceWithGravityOption(onChanged: _onCurveChanged);
        break;
      case CurveType.easeIn:
        curveOption = CubicOption(
            cubicType: CubicType.easeIn, onChanged: _onCurveChanged);
        break;
      case CurveType.easeInOut:
        curveOption = CubicOption(
            cubicType: CubicType.easeInOut, onChanged: _onCurveChanged);
        break;
      case CurveType.easeOut:
        curveOption = CubicOption(
            cubicType: CubicType.easeOut, onChanged: _onCurveChanged);
        break;
      default:
        curveOption = BounceOption(onChanged: _onCurveChanged);
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurveIllustration(curve),
        const SizedBox(height: SizeConstant.xs),
        curveOption
      ],
    );
  }

  void _onCurveChanged(int duration, Curve curve) {
    setState(() {
      this.curve = curve;
    });
  }
}
