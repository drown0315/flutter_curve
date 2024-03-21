import 'package:flutter_curve/flutter_curve.dart';

import 'curve_option.dart';

class BounceOption extends CurveOption<BounceCurve> {
  const BounceOption(
      {super.key, required super.onChanged, required super.width});

  @override
  CurveOptionsState createState() {
    return BounceOptionState();
  }
}

class BounceOptionState extends CurveOptionsState<BounceOption> {
  late final _initialCurve = const BounceCurve();
  late BounceCurve _curCurve = _initialCurve;

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
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(BounceCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}
