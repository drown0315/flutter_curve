import 'package:flutter/material.dart';

/// Opacity + Rotate + Translation + Scale effect example.
class EffectAnimationList extends StatelessWidget {
  const EffectAnimationList(
      {super.key,
      required this.curve,
      required this.duration,
      required this.width,
      required this.height});

  final Curve curve;
  final Duration duration;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          OpacityExample(
            curve: Curves.easeInOut,
            duration: duration,
          ),
          RotateExample(
            curve: Curves.easeInOut,
            duration: duration,
          ),
          TranslationExample(
            curve: Curves.easeInOut,
            duration: duration,
          ),
          ScaleExample(
            curve: Curves.easeInOut,
            duration: duration,
          ),
        ],
      ),
    );
  }
}

abstract class _EffectContainer extends StatefulWidget {
  const _EffectContainer({
    super.key,
    required this.curve,
    required this.duration,
  });

  final Curve curve;
  final Duration duration;
}

abstract class _EffectContainerState extends State<_EffectContainer>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ignore: avoid_unnecessary_containers
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: buildAnimatedEffect(
                child: Container(
              width: 50 * 0.5,
              height: 50 * 0.7,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            ))),
        _buildEffectText(),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildAnimatedEffect({required Widget child});

  Widget _buildEffectText() {
    return Text(effectName,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ));
  }

  String get effectName;
}

class OpacityExample extends _EffectContainer {
  const OpacityExample({
    super.key,
    required super.curve,
    required super.duration,
  });

  @override
  State<StatefulWidget> createState() {
    return _OpacityExampleState();
  }
}

class _OpacityExampleState extends _EffectContainerState {
  late final animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

  @override
  Widget buildAnimatedEffect({required Widget child}) {
    return FadeTransition(opacity: animation, child: Center(child: child));
  }

  @override
  String get effectName => 'opacity';
}

class RotateExample extends _EffectContainer {
  const RotateExample({
    super.key,
    required super.curve,
    required super.duration,
  });

  @override
  State<StatefulWidget> createState() {
    return _RotateExampleState();
  }
}

class _RotateExampleState extends _EffectContainerState {
  late final animation = Tween<double>(begin: 0.0, end: 0.5)
      .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

  @override
  Widget buildAnimatedEffect({required Widget child}) {
    return RotationTransition(
      turns: animation,
      alignment: Alignment.center,
      child: Center(child: child),
    );
  }

  @override
  String get effectName => 'rotate';
}

class TranslationExample extends _EffectContainer {
  const TranslationExample({
    super.key,
    required super.curve,
    required super.duration,
  });

  @override
  State<StatefulWidget> createState() {
    return _TranslationExampleState();
  }
}

class _TranslationExampleState extends _EffectContainerState {
  late final animation =
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.28))
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

  @override
  Widget buildAnimatedEffect({required Widget child}) {
    return SlideTransition(
      position: animation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ),
    );
  }

  @override
  String get effectName => 'translation';
}

class ScaleExample extends _EffectContainer {
  const ScaleExample({
    super.key,
    required super.curve,
    required super.duration,
  });

  @override
  State<StatefulWidget> createState() {
    return _ScaleExampleState();
  }
}

class _ScaleExampleState extends _EffectContainerState {
  late final animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

  @override
  Widget buildAnimatedEffect({required Widget child}) {
    return ScaleTransition(
      scale: animation,
      child: Center(child: child),
    );
  }

  @override
  String get effectName => 'scale';
}
