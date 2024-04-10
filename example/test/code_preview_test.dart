import 'package:example/src/example/widgets/code_preview/code_preview.dart';
import 'package:example/src/example/widgets/code_preview/ease_code_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';
import 'package:flutter_test/flutter_test.dart';

const double _defaultWidth = 200;
const Duration _defaultDuration = Duration(milliseconds: 1000);

void main() {
  group('Curve Code Preview', () {
    testWidgets('Spring curve display correct', (tester) async {
      /// Arrange.
      final SpringCurve curve = SpringCurve(friction: 200, tension: 20);
      final SpringBasicCodePreview codePreview = SpringBasicCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('SpringCurve'), findsOneWidget);
      expect(
          find.textContaining('friction: ${curve.friction}'), findsOneWidget);
      expect(find.textContaining('tension: ${curve.tension}'), findsOneWidget);
    });

    testWidgets('Advanced Spring curve display correct', (tester) async {
      /// Arrange.
      final SpringCurve curve = SpringCurve.advance(
          damping: 23, stiffness: 30, mass: 2.0, velocity: 0.3);
      final SpringAdvanceCodePreview codePreview = SpringAdvanceCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('SpringCurve'), findsOneWidget);
      expect(find.textContaining('damping: ${curve.damping}'), findsOneWidget);
      expect(
          find.textContaining('stiffness: ${curve.stiffness}'), findsOneWidget);
      expect(find.textContaining('mass: ${curve.mass}'), findsOneWidget);
      expect(
          find.textContaining('velocity: ${curve.velocity}'), findsOneWidget);
    });

    testWidgets('Bounce curve', (tester) async {
      /// Arrange.
      const BounceCurve curve = BounceCurve();
      const BounceCodePreview codePreview = BounceCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('BounceCurve'), findsOneWidget);
      expect(
          find.textContaining('frequency: ${curve.frequency}'), findsOneWidget);
      expect(
          find.textContaining('friction: ${curve.friction}'), findsOneWidget);
    });

    testWidgets('Gravity curve', (tester) async {
      /// Arrange.
      const GravityCurve curve = GravityCurve();
      const GravityCodePreview codePreview = GravityCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('GravityCurve'), findsOneWidget);
      expect(find.textContaining('bounciness: ${curve.bounciness}'),
          findsOneWidget);
      expect(find.textContaining('elasticity: ${curve.elasticity}'),
          findsOneWidget);
    });

    testWidgets('ForceWithGravity curve', (tester) async {
      /// Arrange.
      const ForceWithGravityCurve curve = ForceWithGravityCurve();
      const ForceWithGravityCodePreview codePreview =
          ForceWithGravityCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('ForceWithGravity'), findsOneWidget);
      expect(find.textContaining('bounciness: ${curve.bounciness}'),
          findsOneWidget);
      expect(find.textContaining('elasticity: ${curve.elasticity}'),
          findsOneWidget);
    });

    testWidgets('EaseIn curve', (tester) async {
      /// Arrange.
      const int friction = 300;
      final CubicCurve curve = CubicCurve.easeIn(friction: friction);
      final EaseCodePreview codePreview = EaseCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('CubicCurve.easeIn'), findsOneWidget);
      expect(find.textContaining('friction: $friction'), findsOneWidget);
    });

    testWidgets('EaseOut curve', (tester) async {
      /// Arrange.
      const int friction = 300;
      final CubicCurve curve = CubicCurve.easeOut(friction: friction);
      final EaseCodePreview codePreview = EaseCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('CubicCurve.easeOut'), findsOneWidget);
      expect(find.textContaining('friction: $friction'), findsOneWidget);
    });

    testWidgets('EaseInOut curve', (tester) async {
      /// Arrange.
      const int friction = 300;
      final CubicCurve curve = CubicCurve.easeInOut(friction: friction);
      final EaseCodePreview codePreview = EaseCodePreview(
        curve: curve,
        duration: _defaultDuration,
        width: _defaultWidth,
      );

      /// Act.
      await tester.pumpWidget(wrapWithMaterialApp(codePreview));

      /// Assert.
      expect(find.textContaining('CubicCurve.easeInOut'), findsOneWidget);
      expect(find.textContaining('friction: $friction'), findsOneWidget);
    });
  });
}

Widget wrapWithMaterialApp(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}
