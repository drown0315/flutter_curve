import 'package:flutter_curve/flutter_curve.dart';

import 'curve_option.dart';

class SpringOption extends CurveOption<SpringCurve> {
  const SpringOption({super.key, required super.onChanged});

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
      ),
      CurveOptionItem(
        title: 'friction',
        onChanged: (friction) {
          _onOptionChanged(_curCurve.copyWith(friction: friction));
        },
        initialValue: _initialCurve.friction,
      ),
      CurveOptionItem(
        title: 'anticipationSize',
        minValue: 0,
        onChanged: (anticipationSize) {
          _onOptionChanged(
              _curCurve.copyWith(anticipationSize: anticipationSize));
        },
        initialValue: _initialCurve.anticipationSize,
      ),
      CurveOptionItem(
        title: 'anticipationStrength',
        minValue: 0,
        onChanged: (anticipationStrength) {
          _onOptionChanged(
              _curCurve.copyWith(anticipationStrength: anticipationStrength));
        },
        initialValue: _initialCurve.anticipationStrength,
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
