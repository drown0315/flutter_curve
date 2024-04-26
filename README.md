# flutter_curve

Flutter Curve library is inspired by [Dynamic.js](https://github.com/michaelvillar/dynamics.js)

To see some demos, check out [flutter_curve_web](https://drown0315.github.io/flutter_curve/).

flutter_curve is to create physics-based animations, to drive animation by curve.

This library lets you easy to customize your physics-based curve animation.

## Example

Use them like you use `Curve`, because `flutter_curve` is a subclass of `Curve`.

Like this:

```dart

late final animation = CurvedAnimation(
  parent: _controller,
  curve: CubicCurve.easeIn(frition: 30),
);
```

```dart

final scrollController = ScrollController();

scrollController.animateTo(0, duration: const Duration(milliseconds: 500),
curve: CubicCurve.easeIn(frition: 30));
```


## Usage

#### 1. add dependencies into you project pubspec.yaml file

```yaml
dependencies:
  flutter_curve: ^1.0.0
```

Run `flutter packages get` in the root directory of your app.

#### 2. import flutter_curve lib

```dart
import 'package:flutter_curve/flutter_curve.dart';
```

#### 3. use flutter_curve

```dart

late final _controller = AnimationController(
  vsync: this,
  duration: widget.duration,
);

late final animation = CurvedAnimation(
  parent: _controller,
  curve: CubicCurve.easeIn(frition: 30),
);
```

## Support Curve

- [x] SpringCurve
- [x] CubicCurve.easeIn
- [x] CubicCurve.easeOut
- [x] CubicCurve.easeInOut
- [x] BounceCurve
- [x] GravityCurve
- [x] ForceWithGravityCurve
