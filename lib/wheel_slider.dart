library wheel_slider;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

//ignore: must_be_immutable
class WheelSlider extends StatefulWidget {
  final double horizontalListHeight,
      horizontalListWidth,
      verticalListHeight,
      verticalListWidth;
  final int totalCount;
  final num initValue;
  final Function(dynamic) onValueChanged;
  final double itemSize;
  final double perspective;
  final double listWidth;
  final double? listHeight;
  final bool isInfinite;
  final bool horizontal;
  final double squeeze;
  final Color? lineColor;
  final Color pointerColor;
  final double pointerHeight, pointerWidth;
  final Widget background;
  final bool isVibrate;

  /// This is a type String, only valid inputs are "default", "light",  "medium", "heavy", "selectionClick".
  final String hapticFeedback;
  final bool showPointer;
  final Widget? pointer;

  /// Change pointer into any desired widget.
  final Widget? customPointer;
  final TextStyle? selectedNumberStyle, unSelectedNumberStyle;
  final List<Widget> children;
  num? currentIndex;
  final ScrollPhysics? scrollPhysics;

  /// - When this is set to FALSE scroll functionality won't work for the occupied region.
  /// - When using customPointer with GestureDetector/InkWell, set it to FALSE to enable gestures.
  /// - When using default pointer set it to default state i.e TRUE.
  final bool allowPointerTappable;

  /// If using interval field please make sure to update [totalCount] value accordingly.
  final num? interval;
  final bool enableAnimation;
  final Duration animationDuration;
  final Curve animationType;

  WheelSlider({
    Key? key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.totalCount,
    required this.initValue,
    required this.onValueChanged,
    this.itemSize = 10,
    this.perspective = 0.0007,
    this.listWidth = 100,
    this.listHeight,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.lineColor = Colors.black87,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = true,
    this.customPointer,
    this.scrollPhysics,
    this.allowPointerTappable = true,
    this.interval = 1,
    this.enableAnimation = true,
    this.animationDuration = const Duration(seconds: 1),
    this.animationType = Curves.easeIn,
  })  : assert(perspective <= 0.01),
        selectedNumberStyle = null,
        unSelectedNumberStyle = null,
        children = barUI(totalCount, horizontal, lineColor, interval ?? 1),
        currentIndex = null,
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight,
                pointerWidth, pointerColor)
            : null,
        super(key: key);

  static Widget? pointerWidget(Widget? customPointer, bool horizontal,
      double pointerHeight, double pointerWidth, Color pointerColor) {
    return customPointer == null
        ? Container(
            height: horizontal ? pointerHeight : pointerWidth,
            width: horizontal ? pointerWidth : pointerHeight,
            color: pointerColor,
          )
        : null;
  }

  static List<Widget> barUI(totalCount, horizontal, lineColor, num interval) {
    return List.generate(
      totalCount + 1,
      (index) => Container(
        height: horizontal
            ? multipleOfFive(index * (interval))
                ? 35.0
                : 20.0
            : 1.5,
        width: horizontal
            ? 1.5
            : multipleOfFive(index * (interval))
                ? 35.0
                : 20.0,
        alignment: Alignment.center,
        child: Container(
          height: horizontal
              ? multipleOfFive(index * (interval))
                  ? 35.0
                  : 20.0
              : 1.5,
          width: horizontal
              ? 1.5
              : multipleOfFive(index * (interval))
                  ? 35.0
                  : 20.0,
          color: lineColor,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  /// Displays numbers instead of lines.
  WheelSlider.number({
    Key? key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.totalCount,
    required this.initValue,
    required this.onValueChanged,
    this.itemSize = 40,
    this.perspective = 0.0007,
    this.listWidth = 100,
    this.listHeight,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = false,
    this.customPointer,
    this.selectedNumberStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.unSelectedNumberStyle = const TextStyle(),
    required this.currentIndex,
    this.scrollPhysics,
    this.allowPointerTappable = true,
    this.interval = 1,
    this.enableAnimation = true,
    this.animationDuration = const Duration(seconds: 1),
    this.animationType = Curves.easeIn,
  })  : assert(perspective <= 0.01),
        lineColor = null,
        children = List.generate(totalCount + 1, (index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              (index * (interval ?? 1)).toStringAsFixed(
                  interval.toString().contains('.')
                      ? interval.toString().split('.').last.length
                      : 0),
              style: (index * (interval ?? 1)) == currentIndex
                  ? selectedNumberStyle
                  : unSelectedNumberStyle,
            ),
          );
        }),
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight,
                pointerWidth, pointerColor)
            : null,
        super(key: key);

  static bool multipleOfFive(num n) {
    while (n > 0) {
      n = n - 5;
    }
    if (n == 0) {
      return true;
    }
    return false;
  }

  /// Gives you the option to replace with your own custom Widget(s).
  WheelSlider.customWidget({
    Key? key,
    this.horizontalListHeight = 50,
    this.horizontalListWidth = double.infinity,
    this.verticalListHeight = 400.0,
    this.verticalListWidth = 50.0,
    required this.totalCount,
    required this.initValue,
    required this.onValueChanged,
    this.itemSize = 10,
    this.perspective = 0.0007,
    this.listWidth = 100,
    this.listHeight,
    this.isInfinite = true,
    this.horizontal = true,
    this.squeeze = 1.0,
    this.pointerColor = Colors.black,
    this.pointerHeight = 50.0,
    this.pointerWidth = 3.0,
    required this.children,
    this.background = const Center(),
    this.isVibrate = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.vibrate,
    this.showPointer = true,
    this.customPointer,
    this.scrollPhysics,
    this.allowPointerTappable = true,
    this.enableAnimation = true,
    this.animationDuration = const Duration(seconds: 1),
    this.animationType = Curves.easeIn,
  })  : assert(perspective <= 0.01),
        lineColor = null,
        selectedNumberStyle = null,
        unSelectedNumberStyle = null,
        currentIndex = null,
        hapticFeedback = hapticFeedbackType.value,
        pointer = customPointer == null
            ? pointerWidget(customPointer, horizontal, pointerHeight,
                pointerWidth, pointerColor)
            : null,
        interval = 1,
        super(key: key);

  @override
  State<WheelSlider> createState() => _WheelSliderState();
}

class HapticFeedbackType {
  final String value;

  const HapticFeedbackType._(this.value);

  static const HapticFeedbackType vibrate = HapticFeedbackType._('vibrate');
  static const HapticFeedbackType lightImpact = HapticFeedbackType._('light');
  static const HapticFeedbackType mediumImpact = HapticFeedbackType._('medium');
  static const HapticFeedbackType heavyImpact = HapticFeedbackType._('heavy');
  static const HapticFeedbackType selectionClick =
      HapticFeedbackType._('selectionClick');
  static List<HapticFeedbackType> values = [
    vibrate,
    lightImpact,
    mediumImpact,
    heavyImpact,
    selectionClick
  ];

  factory HapticFeedbackType.fromString(String input) =>
      values.firstWhere((element) => element.value == input);
}

class _WheelSliderState extends State<WheelSlider> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  Future<int> getItemIndex() async {
    for (int i = 0; i < widget.totalCount; i++) {
      if (i * (widget.interval ?? 1) == widget.initValue) {
        return i;
      }
    }
    return 0;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int itemIndex = await getItemIndex();
      if (_scrollController.hasClients) {
        if (widget.enableAnimation) {
          _scrollController.animateToItem(itemIndex,
              duration: widget.animationDuration, curve: widget.animationType);
        } else {
          _scrollController.jumpToItem(
            itemIndex,
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.horizontal
          ? widget.horizontalListHeight
          : widget.verticalListHeight,
      width: widget.horizontal
          ? widget.horizontalListWidth
          : widget.verticalListWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.background,
          WheelChooser.custom(
            controller: _scrollController,
            onValueChanged: (val) async {
              if (widget.isVibrate) {
                if (widget.hapticFeedback == 'vibrate') {
                  await HapticFeedback.vibrate();
                } else if (widget.hapticFeedback == 'light') {
                  await HapticFeedback.lightImpact();
                } else if (widget.hapticFeedback == 'medium') {
                  await HapticFeedback.mediumImpact();
                } else if (widget.hapticFeedback == 'heavy') {
                  await HapticFeedback.heavyImpact();
                } else if (widget.hapticFeedback == 'selectionClick') {
                  await HapticFeedback.selectionClick();
                } else {
                  await HapticFeedback.vibrate();
                }
              }
              setState(() {
                widget.onValueChanged(val * (widget.interval ?? 1));
              });
            },
            children: widget.children,
            startPosition: null,
            horizontal: widget.horizontal,
            isInfinite: widget.isInfinite,
            itemSize: widget.itemSize,
            perspective: widget.perspective,
            listWidth: widget.listWidth,
            listHeight: widget.listHeight,
            squeeze: widget.squeeze,
            physics: widget.scrollPhysics,
          ),
          IgnorePointer(
            ignoring: widget.allowPointerTappable,
            child: Visibility(
              visible: widget.showPointer,
              child: widget.customPointer ?? widget.pointer!,
            ),
          ),
          // For details on this widget check out the document here https://api.flutter.dev/flutter/widgets/IgnorePointer-class.html
        ],
      ),
    );
  }
}
