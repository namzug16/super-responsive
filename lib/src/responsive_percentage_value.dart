import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/extensions.dart';
import 'package:super_responsive/super_responsive.dart';

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
