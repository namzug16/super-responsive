import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/range.dart';
import 'package:super_responsive/src/super_responsive.dart';

/// Helper typedef for [ResponsiveNum] extensions.
typedef Condition = bool Function(double value);

/// Extensions for Num containing [min], [max], and [per]
extension ResponsiveNum on double {
  /// Clamps your value with only a maximum value
  double max(double max) => this.clamp(double.negativeInfinity, max);

  /// Clamps your value with only a minimum value
  double min(double min) => this.clamp(min, double.maxFinite);

  /// Return the percentage of the given value
  ///
  /// The percentage must be between 0 and 100
  double per(double percentage) {
    assert(percentage >= 0);
    assert(percentage <= 100);

    return this * percentage / 100;
  }

  /// Return the given value if the condition is true
  ///
  /// ```dart
  /// // this means that if the Height of the screen is less than 600
  /// // then the final value will be 700
  /// context.mediaQueryHeight.when( (value) => value < 600, 700 );
  /// ```
  double when(Condition condition, double value) =>
      condition(this) ? value : this;
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

  /// Returns custom values from the closes [SuperResponsive] widget
  /// in the widget tree
  Map<String, double> get customValues =>
      SuperResponsive.of(this).customValues == null
          ? <String, double>{}
          : SuperResponsive.of(this).customValues!(this);

  /// Returns [Breakpoints.when] with a maxWidth equal to the current
  /// screen width
  T whenBreakpoints<T extends Object?>({
    required T Function(double breakpoint) first,
    required T Function(double breakpoint) second,
    T Function(double breakpoint)? third,
    T Function(double breakpoint)? fourth,
    T Function(double breakpoint)? fifth,
    T Function(double breakpoint)? sixth,
  }) =>
      breakpoints.when<T>(
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

  /// Maps the size of the screen from the range breakpoints.extremes
  /// to the given range [min] - [max] and inverses it.
  /// See [SuperResponsive] for more info.
  ///
  /// ```dart
  /// // instead of returning 100 when the breakpoint is first, it
  /// // will return 0, and when the breakpoints is last, it will return 100
  /// // in short, the inverse of the original responsiveValue()
  /// context.responsiveInverseValue(0, 100);
  /// ```
  double responsiveInverseValue(double min, double max) =>
      SuperResponsive.of(this).responsiveInverseValueOfExtremes(this, min, max);

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
