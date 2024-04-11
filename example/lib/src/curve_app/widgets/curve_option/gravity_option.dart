import 'package:flutter_curve/flutter_curve.dart';

import 'curve_option.dart';

class GravityOption extends CurveOption<GravityCurve> {
  const GravityOption(
      {super.key, required super.onChanged, required super.width});

  @override
  CurveOptionsState createState() {
    return GravityOptionState();
  }
}

class GravityOptionState extends CurveOptionsState<GravityOption> {
  late final _initialCurve = const GravityCurve();
  late GravityCurve _curCurve = _initialCurve;

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'bounciness',
        onChanged: (bounciness) {
          _onOptionChanged(_curCurve.copyWith(bounciness: bounciness));
        },
        initialValue: _initialCurve.bounciness,
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'elasticity',
        onChanged: (elasticity) {
          _onOptionChanged(_curCurve.copyWith(elasticity: elasticity));
        },
        initialValue: _initialCurve.elasticity,
        width: widget.width,
      ),
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(GravityCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}

class ForceWithGravityOption extends CurveOption<ForceWithGravityCurve> {
  const ForceWithGravityOption(
      {super.key, required super.onChanged, required super.width});

  @override
  CurveOptionsState createState() {
    return ForceWithGravityOptionState();
  }
}

class ForceWithGravityOptionState
    extends CurveOptionsState<ForceWithGravityOption> {
  late final _initialCurve = const ForceWithGravityCurve();
  late ForceWithGravityCurve _curCurve = _initialCurve;

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'bounciness',
        onChanged: (bounciness) {
          _onOptionChanged(_curCurve.copyWith(bounciness: bounciness));
        },
        initialValue: _initialCurve.bounciness,
        width: widget.width,
      ),
      CurveOptionItem(
        title: 'elasticity',
        onChanged: (elasticity) {
          _onOptionChanged(_curCurve.copyWith(elasticity: elasticity));
        },
        initialValue: _initialCurve.elasticity,
        width: widget.width,
      ),
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(ForceWithGravityCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}
