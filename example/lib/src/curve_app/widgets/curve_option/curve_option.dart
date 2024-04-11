import 'package:flutter/material.dart';

import '../../../style.dart';

typedef OptionChanged<T extends Curve> = void Function(
    Duration duration, T curve);

/// Slider Option of curve
abstract class CurveOption<T extends Curve> extends StatefulWidget {
  const CurveOption({Key? key, required this.onChanged, required this.width})
      : super(key: key);

  final OptionChanged<T> onChanged;
  final double width;

  @override
  CurveOptionsState createState();
}

abstract class CurveOptionsState<T extends CurveOption> extends State<T> {
  final Duration _initialDuration = const Duration(milliseconds: 1000);
  late Duration duration = _initialDuration;

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
              duration = Duration(milliseconds: value);
              onDurationChanged(duration);
            },
            initialValue: _initialDuration.inMilliseconds,
            width: widget.width,
            maxValue: 5000,
          ),
          ...buildConfigs(),
        ]..expand(
                (element) => [element, const SizedBox(height: SizeConstant.xs)])
            .toList()
            .removeLast(),
      ),
    );
  }

  List<CurveOptionItem> buildConfigs();

  /// Called when duration changed.
  ///
  void onDurationChanged(Duration duration);
}

class CurveOptionItem extends StatefulWidget {
  const CurveOptionItem(
      {super.key,
      required this.title,
      this.minValue = 1,
      this.maxValue = 1000,
      required this.onChanged,
      required this.initialValue,
      required this.width});

  final String title;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final double width;
  final ValueChanged<int> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _CurveOptionItemState();
  }
}

class _CurveOptionItemState extends State<CurveOptionItem> {
  final TextStyle _textStyle = const TextStyle(
      fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500);
  late int _sliderValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
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
