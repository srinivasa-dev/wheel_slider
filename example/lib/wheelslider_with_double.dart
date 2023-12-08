import 'package:example/widgets/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

class WheelSliderWithDouble extends StatefulWidget {
  const WheelSliderWithDouble({Key? key}) : super(key: key);

  @override
  State<WheelSliderWithDouble> createState() => _WheelSliderWithDoubleState();
}

class _WheelSliderWithDoubleState extends State<WheelSliderWithDouble> {
  final int _totalCount = 10;
  final num _initValue = 0.5;
  num _currentValue = 0.5;

  final int _nTotalCount = 100;
  final num _nInitValue = 25.5;
  num _nCurrentValue = 25.5;

  final int _kTotalCount = 1000;
  final num _kInitValue = 0.1;
  num _kCurrentValue = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Wheel Slider',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBox(
                title: 'Default Wheel Slider',
                wheelSlider: WheelSlider(
                  interval: 0.1,
                  totalCount: _totalCount,
                  initValue: _initValue,
                  onValueChanged: (val) {
                    setState(() {
                      _currentValue = val;
                    });
                  },
                  hapticFeedbackType: HapticFeedbackType.vibrate,
                  pointerColor: Colors.redAccent,
                ),
                valueText: Text(
                  _currentValue.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 18.0,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomBox(
                title: 'Numbered Wheel Slider',
                wheelSlider: WheelSlider.number(
                  interval: 0.5,
                  horizontal: true,
                  horizontalListWidth: 300.0,
                  itemSize: 50,
                  perspective: 0.01,
                  totalCount: _nTotalCount,
                  initValue: _nInitValue,
                  unSelectedNumberStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  selectedNumberStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  currentIndex: _nCurrentValue,
                  onValueChanged: (val) {
                    setState(() {
                      _nCurrentValue = val;
                    });
                  },
                  hapticFeedbackType: HapticFeedbackType.heavyImpact,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              CustomBox(
                title: 'Numbered Wheel Slider',
                wheelSlider: WheelSlider.number(
                  interval: 0.001,
                  horizontal: false,
                  verticalListHeight: 300.0,
                  verticalListWidth: 200.0,
                  perspective: 0.01,
                  listWidth: 200,
                  totalCount: _kTotalCount,
                  initValue: _kInitValue,
                  unSelectedNumberStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  selectedNumberStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  currentIndex: _kCurrentValue,
                  onValueChanged: (val) {
                    setState(() {
                      _kCurrentValue = val;
                    });
                  },
                  hapticFeedbackType: HapticFeedbackType.heavyImpact,
                  animationType: Curves.elasticOut,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
