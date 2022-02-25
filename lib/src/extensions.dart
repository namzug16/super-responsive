import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/range.dart';
import 'package:super_responsive/src/super_responsive.dart';

/// Helper typedef for [ResponsiveNum] extensions.
typedef Condition = bool Function(num value);

/// Extensions for Num containing [min], [max], and [per]
extension ResponsiveNum on num {
  /// Clamps your value with only a maximum value
  num max(num max) => this.clamp(double.negativeInfinity, max);

  /// Clamps your value with only a minimum value
  num min(num min) => this.clamp(min, double.maxFinite);

  /// Return the percentage of the given value
  ///
  /// The percentage must be between 0 and 100
  double per(double percentage) {
    assert(percentage >= 0);
    assert(percentage <= 100);

    return this * percentage / 100;
  }
}

/// Extensions for BoxConstraints containing [perWidth] and [perHeight]
extension ResponsiveBoxConstraints on BoxConstraints {

  /// Returns the the percentage of the maxWidth
  ///
  /// constraints.maxWidth.per(percentage);
  double perWidth(double percentage) => this.maxWidth.per(percentage);

  /// Returns the the percentage of the maxHeight
  ///
  /// constraints.maxHeight.per(percentage);
  double perHeight(double percentage) => this.maxHeight.per(percentage);
}

/// Extensions for [BuildContext] containing [breakpoints], [responsiveValue],
/// [customResponsiveValue], [currentBreakPoint]
extension ResponsiveContext on BuildContext {
  /// Returns break points from the closest [SuperResponsive] widget
  /// in the widget tree
  Breakpoints get breakpoints => SuperResponsive.of(this).breakpoints;

  /// Returns [Breakpoints.when] with a maxWidth equal to the current
  /// screen width
  double whenBreakpoints({
    required BreakPointValue first,
    required BreakPointValue second,
    BreakPointValue? third,
    BreakPointValue? fourth,
    BreakPointValue? fifth,
    BreakPointValue? sixth,
  }) =>
      breakpoints.when(
        maxWidth: mediaQueryWidth,
        first: first,
        second: second,
        third: third,
        fourth: fourth,
        fifth: fifth,
        sixth: sixth,
      );

  /// Returns the current break point.
  /// see [SuperResponsive] for more info
  double get currentBreakpoint =>
      SuperResponsive.of(this).breakpoints.currentBreakPoint(
            MediaQuery.of(this).size.width,
          );

  /// Maps the size of the screen from the range breakpoints.extremes
  /// to the given range [min] - [max].
  /// See [SuperResponsive] for more info.
  double responsiveValue(double min, double max) =>
      SuperResponsive.of(this).responsiveValueOfExtremes(this, min, max);

  /// Maps the size of the screen from the range [breakpointsRange]
  /// to the given range [valueRange.min] - [valueRange.max].
  double customResponsiveValue({
    required Range Function(Breakpoints breakpoints) breakpointsRange,
    required Range valueRange,
  }) =>
      mapValue(
        MediaQuery.of(this).size.width,
        breakpointsRange(breakpoints).min,
        breakpointsRange(breakpoints).max,
        valueRange.min,
        valueRange.max,
      );

  /// Returns MediaQuery.of(context).size.width.
  double get mediaQueryWidth => MediaQuery.of(this).size.width;

  /// Returns MediaQuery.of(context).size.height.
  double get mediaQueryHeight => MediaQuery.of(this).size.height;
}
