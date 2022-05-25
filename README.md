# Wheel Slider

Wheel Slider allows you to scroll through with a wheel like look, which have a bunch of customization.

[![pub package](https://img.shields.io/pub/v/wheel_slider)](https://pub.dev/packages/wheel_slider) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

![gif of wheel slider](https://media.giphy.com/media/hEfuhVz0l1Orqlar8V/giphy.gif)

> Wheel Slider is built upon [`wheel_chooser`](https://pub.dev/packages/wheel_chooser)

## Features

* Display numbers instead of lines.
* Horizontal/Vertical scroll.
* Vibrate on scroll.
* Add background widget to the slider.
* Change _Lines_ or _Pointer_ color.
* Change `TextStyle` for number slider.

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
),
```

#### Properties

* `currentIndex` - Gets the current value as you scroll the Number Slider.
* `perspective` - Change the way you want the slider to look from a flat to a wheel like shape and the value must be <= 0.01.
* `squeeze` - Adjust the spacing between each item in the slider.
* `isVibrate` - To turn on/off vibration while scrolling.
* `itemSize` - Size of each item in the slider.
* `background` - Use any widget to add as a background to the slider.

