import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/range.dart';
import 'package:super_responsive/super_responsive.dart';

/// Widget used to make available our [breakpoints] in the entire
/// widget three, it also exposes
class SuperResponsive extends InheritedWidget {
  /// Creates an instance of [SuperResponsive] widget
  const SuperResponsive({
    Key? key,
    required this.breakpoints,
    required Widget child,
  }) : super(key: key, child: child);

  /// [SuperResponsive]'s break points
  final Breakpoints breakpoints;

  /// The data from the closest instance of this class that encloses the given
  /// context.
  ///
  /// You can use this function to query your break points, it also exposes
  /// the method [responsiveValueOfExtremes] see [SuperResponsive] for more
  /// information
  static SuperResponsive of(BuildContext context) {
    final SuperResponsive? result =
        context.dependOnInheritedWidgetOfExactType<SuperResponsive>();
    assert(result != null, 'No SuperResponsive Widget found in context');
    return result!;
  }

  /// Maps the size of the screen from the range ```breakpoints.last``` -
  /// ```breakpoints.first``` to the given range [min] - [max]
  double responsiveValueOfExtremes(
    BuildContext context,
    double min,
    double max,
  ) =>
      mapValue(
        MediaQuery.of(context).size.width,
        breakpoints.last,
        breakpoints.first,
        min,
        max,
      );

  @override
  bool updateShouldNotify(SuperResponsive oldWidget) => false;
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
