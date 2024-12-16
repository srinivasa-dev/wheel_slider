library wheel_slider;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

/// A customizable wheel slider widget with support for horizontal/vertical orientations,
/// custom pointer, haptic feedback, animations, and more.
//ignore: must_be_immutable
class WheelSlider extends StatefulWidget {
  /// Height of the horizontal list view.
  final double horizontalListHeight;

  /// Width of the horizontal list view.
  final double horizontalListWidth;

  /// Height of the vertical list view.
  final double verticalListHeight;

  /// Width of the vertical list view.
  final double verticalListWidth;

  /// The total number of items in the slider.
  final int totalCount;

  /// The initial value to display in the slider.
  final num initValue;

  /// Callback function that is triggered when the slider value changes.
  final Function(dynamic) onValueChanged;

  /// Size of each item in the slider.
  final double itemSize;

  /// Perspective effect of the list. Values <= 0.01 are recommended.
  final double perspective;

  /// Width of the list view.
  final double listWidth;

  /// Height of the list view.
  final double? listHeight;

  /// Enables or disables infinite scrolling.
  final bool isInfinite;

  /// Sets the orientation of the slider. `true` for horizontal, `false` for vertical.
  final bool horizontal;

  /// Squeeze factor for the items in the slider.
  final double squeeze;

  /// Color of the slider lines.
  final Color? lineColor;

  /// Color of the pointer.
  final Color pointerColor;

  /// Height of the pointer.
  final double pointerHeight;

  /// Width of the pointer.
  final double pointerWidth;

  /// Background widget displayed behind the slider.
  final Widget background;

  /// Enables or disables haptic feedback.
  final bool isVibrate;

  /// Type of haptic feedback to be used.
  /// Valid values: "default", "light", "medium", "heavy", "selectionClick".
  final String hapticFeedback;

  /// Determines if the pointer is visible.
  final bool showPointer;

  /// Custom pointer widget.
  final Widget? pointer;

  /// Allows replacing the default pointer with a custom widget.
  final Widget? customPointer;

  /// Text style for the selected number in the slider.
  final TextStyle? selectedNumberStyle;

  /// Text style for unselected numbers in the slider.
  final TextStyle? unSelectedNumberStyle;

  /// A list of custom child widgets for the slider.
  final List<Widget> children;

  /// The currently selected index in the slider.
  num? currentIndex;

  /// Scroll physics for the list view.
  final ScrollPhysics? scrollPhysics;

  /// Enables or disables tappable pointer interactions.
  /// - `true`: The pointer is not tappable.
  /// - `false`: Tapping functionality is enabled for custom gestures.
  final bool allowPointerTappable;

  /// Interval value between slider steps. Update [totalCount] accordingly.
  final num? interval;

  /// Enables or disables animation for initial value display.
  final bool enableAnimation;

  /// Duration of the animation for initial value display.
  final Duration animationDuration;

  /// Type of animation curve to use.
  final Curve animationType;

  /// Controller for the scroll position of the slider.
  final FixedExtentScrollController? controller;

  /// Constructs a WheelSlider with line-based UI.
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
    this.controller,
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

  /// Generates a pointer widget for a wheel slider.
  /// If `customPointer` is provided, the method returns `null`,
  /// allowing the custom widget to be used instead of the default pointer.

  /// Parameters:
  /// - customPointer: Custom pointer widget. If null, a default pointer is created.
  /// - horizontal: Determines the pointer's orientation (true = horizontal, false = vertical).
  /// - pointerHeight: Height of the pointer in horizontal orientation.
  /// - pointerWidth: Width of the pointer in vertical orientation.
  /// - pointerColor: Color of the pointer.

  /// Returns:
  /// - A default `Container` widget for the pointer, or `null` if a custom pointer is provided.

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


  /// Generates a list of bar UI elements for tick marks on a wheel slider.
  /// Long bars are created at intervals that are multiples of 5 for emphasis.

  /// Parameters:
  /// - totalCount: Total number of bars to generate.
  /// - horizontal: Determines the orientation (true = horizontal, false = vertical).
  /// - lineColor: Color of the bars.
  /// - interval: Value interval between consecutive tick marks.

  /// Returns:
  /// - A list of `Container` widgets representing tick marks, with varying sizes.

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

  /// Constructs a WheelSlider with numbered UI.
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
    this.controller,
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

  /// Utility function to check if a number is a multiple of 5.
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
    this.controller,
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


/// Defines a haptic feedback type using a private constructor.
class HapticFeedbackType {
  /// The string representation of the haptic feedback type.
  /// This value is used internally to map the feedback type to the appropriate
  /// platform-specific haptic feedback method.
  final String value;

  const HapticFeedbackType._(this.value);

  /// Vibrate: Produces a standard vibration feedback
  static const HapticFeedbackType vibrate = HapticFeedbackType._('vibrate');

  /// Light Impact: Generates a subtle haptic feedback
  static const HapticFeedbackType lightImpact = HapticFeedbackType._('light');

  /// Medium Impact: Creates a more pronounced haptic feedback compared to light impact
  static const HapticFeedbackType mediumImpact = HapticFeedbackType._('medium');

  /// Heavy Impact: Produces strong haptic feedback
  static const HapticFeedbackType heavyImpact = HapticFeedbackType._('heavy');

  /// Selection Click: Mimics a physical click
  static const HapticFeedbackType selectionClick = HapticFeedbackType._('selectionClick');
  /// List of all predefined haptic feedback types:
  static List<HapticFeedbackType> values = [
    vibrate,
    lightImpact,
    mediumImpact,
    heavyImpact,
    selectionClick
  ];

  /// Creates a HapticFeedbackType instance from a string.
  /// Throws an error if the input does not match any predefined type.
  factory HapticFeedbackType.fromString(String input) =>
      values.firstWhere((element) => element.value == input);
}

/// This class manages the state of the [WheelSlider] widget.
class _WheelSliderState extends State<WheelSlider> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  /// Asynchronously calculates the index of the initial value in the wheel.
  ///
  /// Loops through the total count of items and finds the index where the
  /// product of the index and the interval matches the initial value.
  /// Returns 0 if no match is found.
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
    // This ensures that the widget scrolls to the initial position after it is built.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.controller == null) {
        int itemIndex = await getItemIndex();
        if (_scrollController.hasClients == true) {
          if (widget.enableAnimation) {
            _scrollController.animateToItem(itemIndex,
                duration: widget.animationDuration, curve: widget.animationType);
          } else {
            _scrollController.jumpToItem(
              itemIndex,
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the tree.
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
          // Background widget displayed behind the wheel.
          widget.background,
          // Custom wheel chooser that handles the scrolling behavior.
          WheelChooser.custom(
            controller: widget.controller ?? _scrollController,
            onValueChanged: (val) async {
              // Handle haptic feedback based on user selection.
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
              if(mounted) {
                // Update the selected value and notify listeners.
                setState(() {
                  widget.onValueChanged(val * (widget.interval ?? 1));
                });
              }
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
          // Pointer widget to indicate the current position.
          IgnorePointer(
            ignoring: widget.allowPointerTappable,
            child: Visibility(
              visible: widget.showPointer,
              child: widget.customPointer ?? widget.pointer!,
            ),
          ),
        ],
      ),
    );
  }
}
