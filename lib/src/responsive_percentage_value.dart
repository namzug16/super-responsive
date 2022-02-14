import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/super_responsive.dart';

/// A util class to write a range in a more readable way.
class Range {
  /// Creates an instance of [Range]
  Range(this.min, this.max);

  /// Maximum value of the range
  final double max;

  /// Minimum value of the range
  final double min;

  @override
  String toString() {
    return "Range: ($min, $max)";
  }
}

/// Return a percentage value -> limit * valuePercentage%
/// and it clamps it to a respective [valueRange] if given.
///
/// This function is used in the [PercentageValueBuilder] widget.
double responsivePercentageValue({
  required double valuePercentage,
  required Range? valueRange,
  required double limit,
}) {
  assert(valuePercentage >= 0 && valuePercentage <= 100,
      "Value percentage must be between 0 and 100");

  if (valueRange == null) {
    return (valuePercentage / 100) * limit;
  }

  return (limit * valuePercentage / 100).clamp(valueRange.max, valueRange.min);
}

/// A callback used in the callback [ResponsiveValueBuilderWidget].
///
/// This callback returns [responsivePercentageValue] with the screen size
/// as its limit.
typedef PercentageValue = double Function(double percentage, [Range? range]);

/// A callback used in the [PercentageValueBuilder] widget.
///
/// It returns the assigned widget and exposes the context of the
/// tree, [constraints] of the available space for the widget in case
/// needed, the global [breakpoints] and two callbacks [percentageValueWidth]
/// and [percentageValueHeight]. See [PercentageValue] for more info.
typedef ResponsiveValueBuilderWidget = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  Breakpoints breakpoints,
  PercentageValue percentageValueWidth,
  PercentageValue percentageValueHeight,
);

/// A util builder class, that exposes the current context of the
/// widget tree, the [BoxConstraints] of the widget, the global
/// [Breakpoints] and two utils callback. see [PercentageValue] for more
/// info on this callbacks.
///
/// If [useScreenSize] is set to false, it will use the available space
/// for the widget obtained from its [BoxConstraints]
class PercentageValueBuilder extends StatelessWidget {
  /// Creates an instance of [PercentageValueBuilder],
  const PercentageValueBuilder({
    Key? key,
    required this.builder,
    this.useScreenSize = false,
  }) : super(key: key);

  /// [PercentageValueBuilder] builder, see [ResponsiveValueBuilderWidget] for
  /// more info.
  final ResponsiveValueBuilderWidget builder;

  /// If [useScreenSize] is set to false, it will use the available space
  /// for the widget obtained from its [BoxConstraints]
  final bool useScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuerySize = MediaQuery.of(context).size;

        return builder(
          context,
          constraints,
          context.breakpoints,
          (double percentage, [Range? range]) => responsivePercentageValue(
            valuePercentage: percentage,
            valueRange: range,
            limit: useScreenSize ? mediaQuerySize.width : constraints.maxWidth,
          ),
          (double percentage, [Range? range]) => responsivePercentageValue(
            valuePercentage: percentage,
            valueRange: range,
            limit: useScreenSize ? mediaQuerySize.width : constraints.maxHeight,
          ),
        );
      },
    );
  }
}
