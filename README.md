# flutter_curve

Flutter Curve library is inspired by [Dynamic.js](http://dynamicsjs.com/)

This library lets you easy to customize your own curve animation.

## Example
<img src="/preview/flutter_curve.gif" width="360" height="808"/>

## Usage

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
curve: CubicCurve.easeIn(frition:30));
```

##### 1. add dependencies into you project pubspec.yaml file

```yaml
dependencies:
  flutter_curve: ^0.0.1
```

Run `flutter packages get` in the root directory of your app.

##### 2. import flutter_curve lib

```dart
import 'package:flutter_curve/flutter_curve.dart';
```

##### 3. use flutter_curve

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

### Support Curve

- [x] SpringCurve
- [x] CubicCurve.easeIn
- [x] CubicCurve.easeOut
- [x] CubicCurve.easeInOut
- [x] BounceCurve
- [x] GravityCurve
- [x] ForceWithGravityCurve
