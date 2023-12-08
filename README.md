# Wheel Slider

Wheel Slider offers a lot of customisation and enables you to scroll around with a wheel-like appearance.

[![pub package](https://img.shields.io/pub/v/wheel_slider)](https://pub.dev/packages/wheel_slider) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

![gif of wheel slider](https://media.giphy.com/media/2NHFjGDJ9AZsQL02SD/giphy.gif)
![gif of wheel slider](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExdnd3cHZxeXpoNHUzOHZkY2c5ZjczY3Y5cmNoNTUwaGFxc2ZoZ2lwdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/m7yxCFXyJZIAOWTSI2/giphy.gif)

> Wheel Slider is built upon [`wheel_chooser`](https://pub.dev/packages/wheel_chooser)

## Features

* 🔢 Display numbers instead of lines.
* ↔↕ Horizontal/Vertical scroll.
* 📳 Vibrate on scroll.
* 🔧 Custom widgets.
* 🔧 Custom pointer.
* 🖼️ Add background widget to the slider.
* 🎨 Change _Lines_ or _Pointer_ color.

## Getting started

#### Installation

Add `wheel_slider:` to your `pubspec.yaml` dependencies then run `flutter pub get`.

```yaml
  dependencies:
    wheel_slider:
```
#### Import
Add this line to import the package.

```dart 
import 'package:wheel_slider/wheel_slider.dart';
```

### Android

Add the vibrate permission to your AndroidManifest.xml file, located in `<project root>/android/app/src/main/AndroidManifest.xml`.

* `android.permission.VIBRATE` - allows access to the vibrator.

```xml
<uses-permission android:name="android.permission.VIBRATE"/>
```

### IOS

Supports vibration with duration and pattern on CoreHaptics devices. On older devices, the pattern is emulated with 500ms long vibrations.

## Usage

To use __Line Slider__:

```dart
WheelSlider(
    totalCount: _totalCount,
    initValue: _initValue,
    onValueChanged: (val) {
        setState(() {
          _currentValue = val;
        });
    },
    hapticFeedbackType: HapticFeedbackType.vibrate,
),
```

To use __Line Slider__ with displaying double value:

```dart
WheelSlider(
    interval: 0.5,  // this field is used to show decimal/double values
    totalCount: _totalCount,
    initValue: _initValue,
    onValueChanged: (val) {
        setState(() {
          _currentValue = val;
        });
    },
    hapticFeedbackType: HapticFeedbackType.vibrate,
),
```

To use __Number Slider__:

```dart
WheelSlider.number(
    perspective: 0.01,
    totalCount: _nTotalCount,
    initValue: _nInitValue,
    unSelectedNumberStyle: const TextStyle(
        fontSize: 12.0,
        color: Colors.black54,
    ),
    currentIndex: _nCurrentValue,
    onValueChanged: (val) {
        setState(() {
          _nCurrentValue = val;
        });
    },
    hapticFeedbackType: HapticFeedbackType.heavyImpact,
),
```

To use __Number Slider__ with displaying double value:

```dart
WheelSlider.number(
    interval: 0.5, // this field is used to show decimal/double values
    perspective: 0.01,
    totalCount: _nTotalCount,
    initValue: _nInitValue,
    unSelectedNumberStyle: const TextStyle(
        fontSize: 12.0,
        color: Colors.black54,
    ),
    currentIndex: _nCurrentValue,
    onValueChanged: (val) {
        setState(() {
          _nCurrentValue = val;
        });
    },
    hapticFeedbackType: HapticFeedbackType.heavyImpact,
),
```

To use __Custom Widget Slider__:

```dart
WheelSlider.customWidget(
    totalCount: 12,
    initValue: 5,
    isInfinite: false,
    scrollPhysics: const BouncingScrollPhysics(),
    children: List.generate(12, (index) => const Center(
        child: FlutterLogo(
            size: 100,
        ),
    )),
    onValueChanged: (val) {
        setState(() {
          _cCurrentValue = val;
        });
    },
    hapticFeedbackType: HapticFeedbackType.vibrate,
    showPointer: false,
    itemSize: 80,
),
```

#### Properties

* `interval` - To display decimal values. By default it is set to 1, when changed `totalCount` also to be updated accordingly.
* `currentIndex` - Gets the current value as you scroll the Number Slider.
* `perspective` - Change the way you want the slider to look from a flat to a wheel like shape and the value must be <= 0.01.
* `squeeze` - Adjust the spacing between each item in the slider.
* `isVibrate` - To turn on/off vibration while scrolling.
* `hapticFeedbackType` - Allows you to change the vibration type.
* `itemSize` - Size of each item in the slider.
* `background` - Use any widget to add as a background to the slider.
* `allowPointerTappable`:
  * When this is set to `false` scroll functionality won't work for the occupied region.
  * When using customPointer with GestureDetector/InkWell, set it to `false` to enable gestures.
  * When using default pointer set it to default state i.e `true`.