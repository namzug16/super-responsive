import 'package:super_responsive/src/utils.dart';

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
    _breakpointsList
      ..add(first)
      ..add(second);
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

    _extremes
      ..add(first)
      ..add(last);
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
  /// given [maxWidth], most of the time it is the
  /// screen width but it can also be any value, for
  /// example,
  ///
  double currentBreakPoint(double maxWidth) {
    final index = indexBreakPoint(
      maxWidth,
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
  ///                   context: context.mediaQueryWidth,
  ///                   first: (breakPoint) => breakPoint, // returns 1000
  ///                   second: (breakPoint) => breakPoint, // returns 500
  ///                   third: (breakPoint) => breakPoint, // returns 500
  ///                 );
  /// ...
  /// ```
  ///
  T when<T extends Object?>({
    required double maxWidth,
    required T Function(double breakpoint) first,
    required T Function(double breakpoint) second,
    T Function(double breakpoint)? third,
    T Function(double breakpoint)? fourth,
    T Function(double breakpoint)? fifth,
    T Function(double breakpoint)? sixth,
  }) {
    final currentBP = currentBreakPoint(maxWidth);
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

    return first(this.first);
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return "breakpoints(first: $first, second: $second, third: $third, fourth: $fourth, fifth: $fifth, sixth: $sixth, last: $last, list: $list, extremes: $extremes)";
  }
}
