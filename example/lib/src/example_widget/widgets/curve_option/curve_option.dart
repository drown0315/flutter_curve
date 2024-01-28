import 'package:flutter/material.dart';

import '../../../style.dart';

/// [duration] ms unit.
typedef OptionChanged<T extends Curve> = void Function(int duration, T curve);

abstract class CurveOption<T extends Curve> extends StatefulWidget {
  const CurveOption({Key? key, required this.onChanged}) : super(key: key);

  final OptionChanged<T> onChanged;

  @override
  CurveOptionsState createState();
}

abstract class CurveOptionsState<T extends CurveOption> extends State<T> {
  final int _initialDuration = 1000;
  late int duration = _initialDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.s),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CurveOptionItem(
            title: 'duration',
            onChanged: (value) {
              duration = value;
              onDurationChanged(duration);
            },
            initialValue: _initialDuration,
          ),
          ...buildConfigs(),
        ]
          ..expand(
              (element) => [element, const SizedBox(height: SizeConstant.xs)])
          .toList()
          .removeLast(),
      ),
    );
  }

  List<CurveOptionItem> buildConfigs();

  /// Called when duration changed.
  ///
  /// [duration]: ms unit
  void onDurationChanged(int duration);
}

class CurveOptionItem extends StatefulWidget {
  const CurveOptionItem(
      {super.key,
      required this.title,
      this.minValue = 1,
      this.maxValue = 1000,
      required this.onChanged,
      required this.initialValue});

  final String title;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _CurveOptionItemState();
  }
}

class _CurveOptionItemState extends State<CurveOptionItem> {
  final TextStyle _textStyle =
      const TextStyle(fontSize: 12, color: Colors.black87);
  late int _sliderValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.86,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopSection(),
          const SizedBox(height: SizeConstant.xs),
          _buildSlider()
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: _textStyle,
        ),
        Text(
          _sliderValue.toString(),
          style: _textStyle,
        )
      ],
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: 20,
      child: Slider(
          value: _sliderValue.toDouble(),
          min: widget.minValue.toDouble(),
          max: widget.maxValue.toDouble(),
          onChanged: (sliderValue) {
            _sliderValue = sliderValue.round();
            setState(() {});
            widget.onChanged.call(_sliderValue);
          }),
    );
  }
}
