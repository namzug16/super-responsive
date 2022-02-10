import 'package:flutter/widgets.dart';

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
  ResponsiveValue superValueWidth,
  ResponsiveValue superValueHeight,
);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.responsiveValueBuilder,
    this.useMediaQuerySize = false,
  }) : super(key: key);

  final ResponsiveValueBuilderWidget responsiveValueBuilder;
  final bool useMediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final mediaQuerySize = MediaQuery.of(context).size;

        return responsiveValueBuilder(
          context,
          constraints,
          (double percentage, [Range? range]) => responsiveValue(
            valuePercentage: percentage,
            valueRange: range,
            limit: useMediaQuerySize ? mediaQuerySize.width : constraints.maxWidth,
          ),
          (double percentage, [Range? range]) => responsiveValue(
            valuePercentage: percentage,
            valueRange: range,
            limit: useMediaQuerySize ? mediaQuerySize.width : constraints.maxHeight,
          ),
        );
      },
    );
  }
}
