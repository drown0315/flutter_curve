import 'package:example/src/example/widgets/code_preview/ease_code_preview.dart';
import 'package:example/src/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../curve_option/spring_option.dart';

part 'spring_code_preview.dart';

part 'bounce_code_preview.dart';

part 'gravity_code_preview.dart';

/// Code Preview.
/// Used to display the code of the curve.
abstract class CodePreview<T extends Curve> extends StatelessWidget {
  const CodePreview({
    Key? key,
    required this.curve,
    required this.width,
    required this.duration,
  }) : super(key: key);

  final T curve;
  final Duration duration;
  final double width;

  /// Only used in build method.
  static CodePreview create(
      {required Curve curve,
      required double width,
      required Duration duration,
      required WidgetRef ref}) {
    if (curve is SpringCurve) {
      final bool isSpringAdvancedMode = ref.watch(springIsAdvancedModeProvider);
      return isSpringAdvancedMode
          ? SpringAdvanceCodePreview(
              curve: curve, width: width, duration: duration)
          : SpringBasicCodePreview(
              curve: curve, width: width, duration: duration);
    } else if (curve is BounceCurve) {
      return BounceCodePreview(curve: curve, width: width, duration: duration);
    } else if (curve is ForceWithGravityCurve) {
      return ForceWithGravityCodePreview(
          curve: curve, width: width, duration: duration);
    } else if (curve is GravityCurve) {
      return GravityCodePreview(curve: curve, width: width, duration: duration);
    } else if (curve is CubicCurve) {
      return EaseCodePreview(curve: curve, width: width, duration: duration);
    } else {
      throw UnimplementedError('Not implemented for $curve');
    }
  }

  TextStyle get textStyle => const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      color: const Color(0xf5f5f5f5),
      padding: const EdgeInsets.all(SizeConstant.m),
      child: SelectableText.rich(
          TextSpan(
            children: [
              _buildCurveNameSpan(),
              const TextSpan(text: '('),
              _buildCurveOption(),
              const TextSpan(text: ')'),
            ],
          ),
          style: textStyle),
    );
  }

  InlineSpan _buildCurveNameSpan() {
    return TextSpan(
        text: getCurveName(),
        style: textStyle.copyWith(fontWeight: FontWeight.bold));
  }

  InlineSpan _buildCurveOption() {
    return TextSpan(
        children: [
      ...getCurveOptionsText()
          .map((optionText) => TextSpan(text: optionText))
          .toList(),
    ]
            .expand((element) => [
                  element,
                  const TextSpan(text: ', '),
                ])
            .toList()
          ..removeLast());
  }

  /// Curve name string. e.g.
  /// ```dart
  /// return 'SpringCurve';
  /// ```
  String getCurveName();

  /// Each string  must be '$optionName: $optionValue'
  /// e.g.
  /// ```dart
  /// return ['frequency: 100')],
  /// ```
  List<String> getCurveOptionsText();
}
