import 'package:example/src/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';

import 'animation_example.dart';
import 'code_preview/code_preview.dart';
import 'curve_illustration.dart';
import 'curve_option/bounce_option.dart';
import 'curve_option/cubic_option.dart';
import 'curve_option/curve_option.dart';
import 'curve_option/gravity_option.dart';
import 'curve_option/spring_option.dart';

enum CurveType {
  spring,
  bounce,
  forceWithGravity,
  gravity,
  easeIn,
  easeOut,
  easeInOut,
}

/// Animated Curve Preview + Curve parameter Setting
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
    final width = kIsWeb ? 300.0 : MediaQuery.sizeOf(context).width * 0.86;
    switch (widget.curveType) {
      case CurveType.spring:
        curveOptionWidget = SpringOption(
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.bounce:
        curveOptionWidget = BounceOption(
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.gravity:
        curveOptionWidget = GravityOption(
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.forceWithGravity:
        curveOptionWidget = ForceWithGravityOption(
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.easeIn:
        curveOptionWidget = CubicOption(
          cubicType: CubicType.easeIn,
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.easeInOut:
        curveOptionWidget = CubicOption(
          cubicType: CubicType.easeInOut,
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      case CurveType.easeOut:
        curveOptionWidget = CubicOption(
          cubicType: CubicType.easeOut,
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
      default:
        curveOptionWidget = BounceOption(
          onChanged: _onCurveChanged,
          width: width,
        );
        break;
    }

    return kIsWeb
        ? _buildBodyForWeb(curveOptionWidget: curveOptionWidget)
        : _buildBodyForApp(curveOptionWidget: curveOptionWidget);
  }

  Widget _buildBodyForApp({required CurveOption curveOptionWidget}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Animated Curve line chart.
        CurveIllustration(
          curve,
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: 200,
        ),
        const SizedBox(height: SizeConstant.s),

        /// Slider Option of curve
        curveOptionWidget,
        const SizedBox(height: SizeConstant.s),

        /// Curved ball animation.
        AnimationExample(
          curve: curve,
          key: ValueKey(curve),
          duration: duration,
          width: MediaQuery.sizeOf(context).width * 0.8,
        ),
      ],
    );
  }

  Widget _buildBodyForWeb({required CurveOption curveOptionWidget}) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Animated Curve line chart.
              CurveIllustration(
                curve,
                width: 400,
                height: 345,
              ),

              const SizedBox(width: SizeConstant.m),

              /// Slider Option of curve
              curveOptionWidget
            ],
          ),
          const SizedBox(height: SizeConstant.l),

          /// Curved ball animation.
          AnimationExample(
            curve: curve,
            key: ValueKey(curve),
            duration: duration,
            width: 600,
          ),

          const SizedBox(height: SizeConstant.l),

          Align(
            alignment: Alignment.topLeft,
            child: CodePreview.create(
                curve: curve, width: 550, duration: duration),
          )
        ],
      ),
    );
  }

  /// Callback when parameter of curve changed.
  void _onCurveChanged(Duration duration, Curve curve) {
    setState(() {
      this.curve = curve;
      this.duration = duration;
    });
  }
}
