import 'package:flutter/widgets.dart';
import 'package:super_responsive/super_responsive.dart';

/// Typedef utils used in [SuperResponsive]'s customValues
typedef CustomValueBuilder = Map<String, double> Function(BuildContext context);

/// Widget used to make available our [breakpoints] in the entire
/// widget three, it also exposes
class SuperResponsive extends InheritedWidget {
  /// Creates an instance of [SuperResponsive] widget
  const SuperResponsive({
    Key? key,
    required this.breakpoints,
    this.customValues,
    required Widget child,
  }) : super(key: key, child: child);

  /// [SuperResponsive]'s break points
  final Breakpoints breakpoints;

  /// [SuperResponsive]'s custom values callback, it exposes the context so
  /// that other extensions can be used in order to calculate your
  /// custom values
  ///
  /// ```dart
  /// ...
  /// customValues: (context) => {
  ///   "title": context.mediaQueryWidth.per(5).clamp(30, 60),
  ///   "card_height": context.mediaQueryHeight.per(20).min(100),
  /// }
  /// ...
  /// ```
  ///
  final CustomValueBuilder? customValues;

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

  /// Maps the size of the screen from the range ```breakpoints.last``` -
  /// ```breakpoints.first``` to the given range [min] - [max] and inverses it.
  double responsiveInverseValueOfExtremes(
    BuildContext context,
    double min,
    double max,
  ) =>
      (min + max) -
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
