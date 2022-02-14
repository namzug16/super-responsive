import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/utils.dart';
import 'package:super_responsive/super_responsive.dart';

/// A callback used by the [Breakpoints]' method [Breakpoints.when]
///
/// it exposes the current break point so that it can be used
/// if wanted.
///
typedef BreakPointValue = double Function(double breakPoint);

/// An utility to keep all your break points in a class,
/// it is mainly used by the [SuperResponsive] widget, that makes
/// it available on the entire widget three
///
///[Breakpoints.first] and [Breakpoints.second] are required.
///
class Breakpoints {
  /// Creates an instance of [Breakpoints]
  ///
  /// it also populates [Breakpoints.list], [Breakpoints.extremes]
  /// and [Breakpoints.last] based on the available break points.
  Breakpoints({
    required this.first,
    required this.second,
    this.third,
    this.fourth,
    this.fifth,
    this.sixth,
  }) {
    _breakpointsList..add(first)..add(second);
    if (third != null) {
      _breakpointsList.add(third!);
      if (fourth != null) {
        _breakpointsList.add(fourth!);
        if (fifth != null) {
          _breakpointsList.add(fifth!);
          if (sixth != null) {
            _breakpointsList.add(sixth!);
          }
        }
      }
    }

    _last = list.isNotEmpty && list.length > 1 ? list.last : 0;

    _extremes..add(first)..add(last);
  }

  /// First break points
  /// it must be greater than the next break points
  final double first;

  /// Second break point
  /// it must be grater than the next break points
  final double second;

  /// Third break point, it is not required
  /// it must be grater than the next break points
  final double? third;

  /// Fourth break point, it  is not required
  /// it must be grater than the next break points
  final double? fourth;

  /// Fifth break point, it is not required
  /// it must be grater than the next break points
  final double? fifth;

  /// Sixth break point, it is not required
  /// it must be grater than the next break points
  final double? sixth;

  /// Returns all your break points a List<int>
  List<double> get list => _breakpointsList;
  final List<double> _breakpointsList = [];

  /// Returns you last break point
  double get last => _last;
  double _last = 0;

  /// Return a List<int> of two elements [Breakpoints.first] and
  /// [Breakpoints.last]
  ///
  List<double> get extremes => _extremes;
  final List<double> _extremes = [];

  /// Returns the current break point.
  ///
  /// Finds out which one is the current break point
  /// by comparing the [list] of break points and the
  /// actual size of the screen
  ///
  double currentBreakPoint(BuildContext context) {
    final index = indexBreakPoint(
      MediaQuery
          .of(context)
          .size
          .width,
      list,
    );

    return list[index];
  }

  /// Calls an specific callback based on the current break point,
  /// only the first and second cases are required.
  ///
  /// if other cases are specified and the [Breakpoints] class
  /// does not contain those break points, it calls the last valid callback.
  /// For example
  /// ```dart
  /// ...
  /// final myValue = breakpoints( first: 1000, second: 500).when(
  ///                   context: context
  ///                   first: (breakPoint) => breakPoint, // returns 1000
  ///                   second: (breakPoint) => breakPoint, // returns 500
  ///                   third: (breakPoint) => breakPoint, // returns 500
  ///                 );
  /// ...
  /// ```
  ///
  double when({
    required BuildContext context,
    required BreakPointValue first,
    required BreakPointValue second,
    BreakPointValue? third,
    BreakPointValue? fourth,
    BreakPointValue? fifth,
    BreakPointValue? sixth,
  }) {
    final currentBP = currentBreakPoint(context);
    if (currentBP == this.first) return first(this.first);
    if (currentBP == this.second) return second(this.second);
    if (third == null) return second(this.second);
    if (currentBP == this.third) return third(this.third ?? last);
    if (fourth == null) return third(this.third ?? last);
    if (currentBP == this.fourth) return fourth(this.fourth ?? last);
    if (fifth == null) return fourth(this.fourth ?? last);
    if (currentBP == this.fifth) return fifth(this.fifth ?? last);
    if (sixth == null) return fifth(this.fifth ?? last);
    if (currentBP == this.sixth) return sixth(this.sixth ?? last);

    return 0;
  }

  @override
  String toString() {
    return "breakpoints(first: $first, second: $second, third: $third, fourth: $fourth, fifth: $fifth, sixth: $sixth, last: $last, list: $list, extremes: $extremes)";
  }
}

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
  double responsiveValueOfExtremes(BuildContext context,
      double min,
      double max,) =>
      mapValue(
        MediaQuery
            .of(context)
            .size
            .width,
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
  Breakpoints get breakpoints =>
      SuperResponsive
          .of(this)
          .breakpoints;

  /// Returns the current break point.
  /// see [SuperResponsive] for more info
  double get currentBreakPoint =>
      SuperResponsive
          .of(this)
          .breakpoints
          .currentBreakPoint(this);


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
  }) => mapValue(
    MediaQuery
        .of(this)
        .size
        .width,
    breakpointsRange(breakpoints).min,
    breakpointsRange(breakpoints).max,
    valueRange.min,
    valueRange.max,
  );


}
