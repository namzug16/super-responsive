import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/utils.dart';

typedef BreakPointValue = double Function(double breakPoint);

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

  double currentBreakPoint(BuildContext context) {
    final index = indexBreakPoint(
      MediaQuery.of(context).size.width,
      list,
    );

    return list[index];
  }

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
      SuperResponsive.of(this).superValueOfExtremes(this, min, max);

  double get currentBreakPoint =>
      SuperResponsive.of(this).breakPoints.currentBreakPoint(this);
}
