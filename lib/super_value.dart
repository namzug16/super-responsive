import 'package:flutter/widgets.dart';
import 'package:super_responsive/utils.dart';

class Range {
  Range(this.start, this.end);

  final double start;
  final double end;

  @override
  String toString() {
    return "Range: ($start, $end)";
  }
}

double superValue({
  required double limitValue,
  required Range limitValueRange,
  required Range valueRange,
}) =>
    mapValue(
      limitValue,
      limitValueRange.start,
      limitValueRange.end,
      valueRange.start,
      valueRange.end,
    );

double superValueMediaQueryWidth({
  required BuildContext context,
  required double width,
  required Range valueRange,
}) =>
    mapValue(
      width,
      0.0,
      MediaQuery.of(context).size.width,
      valueRange.start,
      valueRange.end,
    );

double superValueMediaQueryHeight({
  required BuildContext context,
  required double height,
  required Range valueRange,
}) =>
    mapValue(
      height,
      0.0,
      MediaQuery.of(context).size.height,
      valueRange.start,
      valueRange.end,
    );

typedef SuperValue = double Function(Range limits);
typedef SuperValueWidgetBuilder = Widget Function(BuildContext context,
    SuperValue superValueWidth, SuperValue superValueHeight);

class SuperValueBuilder extends StatelessWidget {
  const SuperValueBuilder({
    Key? key,
    required this.superValue,
  }) : super(key: key);

  final SuperValueWidgetBuilder superValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return superValue(
          context,
          (Range range) => superValueMediaQueryWidth(
            context: context,
            width: constraints.maxWidth,
            valueRange: range,
          ),
          (Range range) => superValueMediaQueryHeight(
            context: context,
            height: constraints.maxHeight,
            valueRange: range,
          ),
        );
      },
    );
  }
}
