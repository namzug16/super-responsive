import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/exposed_utils.dart';

class BreakPoints {
  final double first;
  final double second;
  final double? third;
  final double? fourth;
  final double? fifth;
  final double? sixth;

  BreakPoints({
    required this.first,
    required this.second,
    this.third,
    this.fourth,
    this.fifth,
    this.sixth,
  }) {
    _breakPointsList
      ..add(first)
      ..add(second);
    if (third != null) {
      _breakPointsList.add(third!);
      if (fourth != null) {
        _breakPointsList.add(fourth!);
        if (fifth != null) {
          _breakPointsList.add(fifth!);
          if (sixth != null) {
            _breakPointsList.add(sixth!);
          }
        }
      }
    }

    _last = list.isNotEmpty && list.length > 1 ? list.last : 0;

    _extremes
      ..add(first)
      ..add(last);
  }

  List<double> get list => _breakPointsList;
  final List<double> _breakPointsList = [];

  double get last => _last;
  double _last = 0;

  List<double> get extremes => _extremes;
  final List<double> _extremes = [];

  @override
  String toString() {
    return "BreakPoints(first: $first, second: $second, third: $third, fourth: $fourth, fifth: $fifth, sixth: $sixth, last: $last, list: $list, extremes: $extremes)";
  }
}

class SuperResponsive extends InheritedWidget {
  const SuperResponsive({
    Key? key,
    required this.breakPoints,
    required Widget child,
  }) : super(key: key, child: child);

  final BreakPoints breakPoints;

  static SuperResponsive of(BuildContext context) {
    final SuperResponsive? result =
        context.dependOnInheritedWidgetOfExactType<SuperResponsive>();
    assert(result != null, 'No SuperResponsive Widget found in context');
    return result!;
  }

  double superValueOfExtremes(BuildContext context, double min, double max) =>
      mapValue(
        MediaQuery.of(context).size.width,
        breakPoints.last,
        breakPoints.first,
        min,
        max,
      );

  @override
  bool updateShouldNotify(SuperResponsive oldWidget) => false;
}

extension ResponsiveContext on BuildContext {
  BreakPoints get breakPoints => SuperResponsive.of(this).breakPoints;

  double responsiveValue(double min, double max) =>
      SuperResponsive.of(this)
          .superValueOfExtremes(this, min, max);
}
