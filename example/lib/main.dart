import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[700],
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              currentIndex: _nCurrentValue,
              onValueChanged: (val) {
                setState(() {
                  _nCurrentValue = val;
                });
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            WheelSlider(
              totalCount: _totalCount,
              initValue: _initValue,
              perspective: 0.01,
              isVibrate: false,
              background: Container(
                width: 250,
                height: double.infinity,
                color: Colors.amberAccent,
              ),
              onValueChanged: (val) {

              },
            ),
          ],
        ),
      ),
    );
  }
}