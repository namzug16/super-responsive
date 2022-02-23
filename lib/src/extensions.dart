import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/range.dart';
import 'package:super_responsive/src/super_responsive.dart';

/// Extensions for Num, containing absolute length units like centimeters
/// and inches, it also contains [min], [max], and [per]
extension ResponsiveNum on num {

  // https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units
  // Absolute length units

  /// Return value in Centimeters
  double get cm => this * 37.8;

  /// Return value in Millimeters
  double get mm => this * 3.78;

  /// Return value in Quarter-millimeters
  double get q => this * 0.945;

  /// Return value in Inches
  double get inc => this * 96;

  /// Return value in Picas
  double get pc => this * 16;

  /// Return value in Points
  double get pt => this * inc/72;

  /// Return value in Pixels
  double get px => this.toDouble();

  /// Clamps your value with only a maximum value
  num max(num max) => this.clamp(double.negativeInfinity, max);

  /// Clamps your value with only a minimum value
  num min(num min) => this.clamp(min, double.maxFinite);

  /// Return the percentage of the given value
  ///
  /// The percentage must be between 0 and 100
  double per(double percentage){
    assert(percentage >= 0);
    assert(percentage <= 100);

    return this*percentage/100;
  }

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
