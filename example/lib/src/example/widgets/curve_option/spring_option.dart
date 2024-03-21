import 'package:flutter_curve/flutter_curve.dart';

import 'curve_option.dart';

class SpringOption extends CurveOption<SpringCurve> {
  const SpringOption(
      {super.key, required super.onChanged, required super.width});

  @override
  CurveOptionsState createState() {
    return SpringOptionsState();
  }
}

class SpringOptionsState extends CurveOptionsState<SpringOption> {
  late final _initialCurve = const SpringCurve();
  late SpringCurve _curCurve = _initialCurve;

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'frequency',
        onChanged: (frequency) {
          _onOptionChanged(_curCurve.copyWith(frequency: frequency));
        },
        initialValue: _initialCurve.frequency,
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'friction',
        onChanged: (friction) {
          _onOptionChanged(_curCurve.copyWith(friction: friction));
        },
        initialValue: _initialCurve.friction,
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'anticipationSize',
        minValue: 0,
        maxValue: 999,
        onChanged: (anticipationSize) {
          _onOptionChanged(
              _curCurve.copyWith(anticipationSize: anticipationSize));
        },
        initialValue: _initialCurve.anticipationSize,
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'anticipationStrength',
        minValue: 0,
        onChanged: (anticipationStrength) {
          _onOptionChanged(
              _curCurve.copyWith(anticipationStrength: anticipationStrength));
        },
        initialValue: _initialCurve.anticipationStrength,
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
