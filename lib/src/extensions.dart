import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/range.dart';
import 'package:super_responsive/src/super_responsive.dart';

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
  double get currentBreakPoint =>
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

/// Extensions for [BuildContext] containing [percentageValueWidth] and [percentageValueHeight]
extension PercentageContext on BuildContext {
  /// It will return a certain specified percentage >= 0 && <= 100 of the
  /// current screen width, the value will be clamped to the [valueRange]
  /// if specified
  double percentageValueWidth(double percentage, [Range? valueRange]) =>
      responsivePercentageValue(
          valuePercentage: percentage,
          valueRange: valueRange,
          limit: MediaQuery.of(this).size.width);

  /// It will return a certain specified percentage >= 0 && <= 100 of the
  /// current screen height, the value will be clamped to the [valueRange]
  /// if specified
  double percentageValueHeight(double percentage, [Range? valueRange]) =>
      responsivePercentageValue(
          valuePercentage: percentage,
          valueRange: valueRange,
          limit: MediaQuery.of(this).size.height);
}

