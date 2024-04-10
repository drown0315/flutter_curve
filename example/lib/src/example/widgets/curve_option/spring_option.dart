import 'package:flutter/material.dart';
import 'package:flutter_curve/flutter_curve.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../style.dart';
import 'curve_option.dart';

/// Spring Curve Option
///  contains: Basic Spring Curve Option and Advanced Spring Curve Option.
class SpringComposeOption extends StatefulWidget {
  const SpringComposeOption(
      {super.key, required this.width, required this.onChanged});

  final double width;
  final OptionChanged<SpringCurve> onChanged;

  @override
  State<SpringComposeOption> createState() => _SpringComposeOptionState();
}

class _SpringComposeOptionState extends State<SpringComposeOption> {
  SpringCurve _initialCurve = SpringCurve();
  late SpringCurve _curCurve = _initialCurve;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCurveOption(),
          const SizedBox(height: SizeConstant.m),
          _buildModeSwitcher()
        ],
      ),
    );
  }

  Widget _buildCurveOption() {
    return Consumer(builder: (_, ref, __) {
      final bool isAdvanced = ref.watch(springIsAdvancedModeProvider);
      return isAdvanced
          ? AdvancedSpringOption(
              onChanged: onOptionChanged,
              width: widget.width,
              initialCurve: _initialCurve,
            )
          : SpringOption(
              onChanged: onOptionChanged,
              width: widget.width,
              initialCurve: _initialCurve,
            );
    });
  }

  /// Mode Switcher. Use to switch between basic and advanced mode.
  /// Basic mode: only tension and friction.
  /// Advanced mode: tension, friction, damping, stiffness, mass, velocity.
  Widget _buildModeSwitcher() {
    return Consumer(
      builder: (_, ref, __) {
        final bool isAdvanced = ref.watch(springIsAdvancedModeProvider);
        return Container(
          constraints: BoxConstraints(maxWidth: widget.width),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Is Advanced ?'),
              const SizedBox(width: SizeConstant.m),
              Switch(
                  value: isAdvanced,
                  onChanged: (value) {
                    _initialCurve = _curCurve;
                    ref.read(springIsAdvancedModeProvider.notifier).state =
                        value;
                  })
            ],
          ),
        );
      },
    );
  }

  void onOptionChanged(Duration duration, SpringCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}

class SpringOption extends CurveOption<SpringCurve> {
  const SpringOption({
    super.key,
    required super.onChanged,
    required super.width,
    required this.initialCurve,
  });

  final SpringCurve initialCurve;

  @override
  CurveOptionsState createState() {
    return SpringOptionsState();
  }
}

class SpringOptionsState extends CurveOptionsState<SpringOption> {
  SpringCurve get _initialCurve => widget.initialCurve;

  late SpringCurve _curCurve = _initialCurve;

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'tension',
        onChanged: (tension) {
          _onOptionChanged(_curCurve.copyWith(tension: tension.toDouble()));
        },
        initialValue: _initialCurve.tension.toInt(),
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'friction',
        onChanged: (friction) {
          _onOptionChanged(_curCurve.copyWith(friction: friction.toDouble()));
        },
        initialValue: _initialCurve.friction.toInt(),
        width: widget.width,
      ),
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(SpringCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}

class AdvancedSpringOption extends CurveOption<SpringCurve> {
  const AdvancedSpringOption({
    super.key,
    required super.onChanged,
    required super.width,
    required this.initialCurve,
  });

  final SpringCurve initialCurve;

  @override
  CurveOptionsState createState() {
    return AdvancedSpringOptionState();
  }
}

class AdvancedSpringOptionState
    extends CurveOptionsState<AdvancedSpringOption> {
  SpringCurve get _initialCurve => widget.initialCurve;
  late SpringCurve _curCurve = _initialCurve;

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'damping',
        onChanged: (damping) {
          _onOptionChanged(
              _curCurve.copyWithAdvance(damping: damping.toDouble()));
        },
        initialValue: _initialCurve.damping.toInt(),
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'stiffness',
        onChanged: (stiffness) {
          _onOptionChanged(
              _curCurve.copyWithAdvance(stiffness: stiffness.toDouble()));
        },
        initialValue: _initialCurve.stiffness.toInt(),
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'mass',
        onChanged: (mass) {
          _onOptionChanged(_curCurve.copyWithAdvance(mass: mass.toDouble()));
        },
        initialValue: _initialCurve.mass.toInt(),
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'velocity',
        onChanged: (velocity) {
          _onOptionChanged(
              _curCurve.copyWithAdvance(velocity: velocity.toDouble()));
        },
        minValue: 0,
        initialValue: _initialCurve.velocity.toInt(),
        width: widget.width,
      ),
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(SpringCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}

/// Whether Spring option is in advanced mode.
/// true: advanced mode, false: basic mode.
///
/// Basic mode: only tension and friction.
/// Advanced mode: tension, friction, damping, stiffness, mass, velocity.
final springIsAdvancedModeProvider = StateProvider<bool>((ref) => false);
