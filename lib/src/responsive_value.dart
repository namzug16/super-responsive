import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';

class Range {
  Range(this.start, this.end);

  final double start;
  final double end;

  @override
  String toString() {
    return "Range: ($start, $end)";
  }
}

double responsiveValue({
  required double valuePercentage,
  required Range? valueRange,
  required double limit,
}) {
  assert(valuePercentage >= 0 && valuePercentage <= 100,
      "Value percentage must be between 0 and 100");

  if (valueRange == null) {
    return (valuePercentage / 100) * limit;
  }

  return (limit * valuePercentage / 100)
      .clamp(valueRange.start, valueRange.end);
}

typedef ResponsiveValue = double Function(double percentage, [Range? range]);
typedef ResponsiveValueBuilderWidget = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  BreakPoints breakPoints,
  ResponsiveValue superValueWidth,
  ResponsiveValue superValueHeight,
);

class ResponsiveValueBuilder extends StatelessWidget {
  const ResponsiveValueBuilder({
    Key? key,
    required this.builder,
    this.useMediaQuerySize = false,
  }) : super(key: key);

  final ResponsiveValueBuilderWidget builder;
  final bool useMediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuerySize = MediaQuery.of(context).size;

        return builder(
          context,
          constraints,
          context.breakPoints,
          (double percentage, [Range? range]) => responsiveValue(
            valuePercentage: percentage,
            valueRange: range,
            limit:
                useMediaQuerySize ? mediaQuerySize.width : constraints.maxWidth,
          ),
          (double percentage, [Range? range]) => responsiveValue(
            valuePercentage: percentage,
            valueRange: range,
            limit: useMediaQuerySize
                ? mediaQuerySize.width
                : constraints.maxHeight,
          ),
        );
      },
    );
  }
}
