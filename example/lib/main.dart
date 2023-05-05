import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final int _totalCount = 100;
  final int _initValue = 50;
  int _currentValue = 50;

  final int _nTotalCount = 50;
  final int _nInitValue = 10;
  int _nCurrentValue = 10;

  final int _cInitValue = 7;
  int _cCurrentValue = 7;

  final List<Map<String, String>> _countryList = [
    {'flag': 'assets/argentina.png', 'name': 'Argentina'},
    {'flag': 'assets/australia.png', 'name': 'Australia'},
    {'flag': 'assets/brazil.png', 'name': 'Brazil'},
    {'flag': 'assets/canada.png', 'name': 'Canada'},
    {'flag': 'assets/cuba.png', 'name': 'Cuba'},
    {'flag': 'assets/hungary.png', 'name': 'Hungary'},
    {'flag': 'assets/iceland.png', 'name': 'Iceland'},
    {'flag': 'assets/india.png', 'name': 'India'},
    {'flag': 'assets/monaco.png', 'name': 'Monaco'},
    {'flag': 'assets/south-africa.png', 'name': 'South Africa'},
    {'flag': 'assets/ukraine.png', 'name': 'Ukraine'},
    {'flag': 'assets/usa.png', 'name': 'USA'},
  ];

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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WheelSlider(
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
              Text(
                _currentValue.toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  height: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              WheelSlider.number(
                horizontal: false,
                verticalListHeight: 300.0,
                perspective: 0.01,
                totalCount: _nTotalCount,
                initValue: _nInitValue,
                unSelectedNumberStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                selectedNumberStyle: const TextStyle(
                  fontSize: 18.0,
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
              const SizedBox(
                height: 40.0,
              ),
              WheelSlider.customWidget(
                totalCount: _countryList.length,
                initValue: _cInitValue,
                isInfinite: false,
                scrollPhysics: const BouncingScrollPhysics(),
                children: List.generate(_countryList.length, (index) => Center(
                  child: Image.asset(
                    _countryList[index]['flag']!,
                    scale: _cCurrentValue == index ? null : 1.3,
                    color: _cCurrentValue == index ? Colors.transparent :Colors.white,
                    colorBlendMode: BlendMode.color,
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
              Text(
                _countryList[_cCurrentValue]['name'].toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  height: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              WheelSlider(
                totalCount: _totalCount,
                initValue: _initValue,
                perspective: 0.01,
                isVibrate: false,
                background: Container(
                  width: 300,
                  height: double.infinity,
                  color: Colors.brown,
                ),
                lineColor: Colors.white,
                customPointer: const ImageIcon(
                  AssetImage('assets/crosshair.png'),
                  color: Colors.black,
                  size: 35.0,
                ),
                onValueChanged: (val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}