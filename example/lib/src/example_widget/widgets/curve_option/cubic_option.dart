import 'package:flutter_curve/flutter_curve.dart';

import 'curve_option.dart';

enum CubicType {
  easeIn,
  easeOut,
  easeInOut,
}

class CubicOption extends CurveOption<CubicCurve> {
  const CubicOption({
    super.key,
    required this.cubicType,
    required super.onChanged,
  });

  final CubicType cubicType;

  @override
  CurveOptionsState createState() {
    return CubicOptionState();
  }
}

class CubicOptionState extends CurveOptionsState<CubicOption> {
  late CubicCurve _curCurve;

  late CubicCurve _initialCurve;

  @override
  void initState() {
    super.initState();
    switch (widget.cubicType) {
      case CubicType.easeIn:
        _initialCurve = CubicCurve.easeIn();
        break;
      case CubicType.easeInOut:
        _initialCurve = CubicCurve.easeInOut();
        break;
      case CubicType.easeOut:
        _initialCurve = CubicCurve.easeOut();
        break;
    }
    _curCurve = _initialCurve;
  }

  @override
  List<CurveOptionItem> buildConfigs() {
    return [
      CurveOptionItem(
        title: 'friction',
        onChanged: (friction) {
          switch (widget.cubicType) {
            case CubicType.easeIn:
              _onOptionChanged(CubicCurve.easeIn(friction: friction));
              break;
            case CubicType.easeInOut:
              _onOptionChanged(CubicCurve.easeInOut(friction: friction));
              break;
            case CubicType.easeOut:
              _onOptionChanged(CubicCurve.easeOut(friction: friction));
              break;
          }
        },
        initialValue: CubicCurve.defaultFriction,
      ),
    ];
  }

  @override
  void onDurationChanged(Duration duration) {
    _onOptionChanged(_curCurve);
  }

  void _onOptionChanged(CubicCurve curve) {
    _curCurve = curve;
    widget.onChanged.call(duration, curve);
  }
}
