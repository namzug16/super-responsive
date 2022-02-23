import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/extensions.dart';
import 'package:super_responsive/src/responsive_layout.dart';
import 'package:super_responsive/src/super_responsive.dart';

/// A util class that can be used with [ResponsiveLayout]
///
/// It returns a [SizedBox.square] with dimension equal to the
/// mapped value from the size of the screen on the range range breakpoints.extremes
/// of the closes [SuperResponsive] widget in the widget
/// tree and its range [min] - [max]
///
class ResponsiveGap extends StatelessWidget {
  /// Creates an instance of [ResponsiveGap]
  const ResponsiveGap(
    this.min,
    this.max, {
    Key? key,
    this.reversed = false,
  }) : super(key: key);

  /// Maximum value of the range
  final double max;

  /// Minimum value of the range
  final double min;

  /// If set to true it will calculate the reversed value. For example
  ///
  /// ```dart
  ///
  /// // reversed = false
  /// 1.25 form range 1.0 - 2.0 to range 2.0 - 3.0 will return 2.25
  ///
  /// // reversed = true
  /// 1.25 form range 1.0 - 2.0 to range 2.0 - 3.0 will return 2.75
  /// 1.75 form range 1.0 - 2.0 to range 2.0 - 3.0 will return 2.15
  ///
  /// ```
  ///
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: reversed
          ? ((max + min) - context.responsiveValue(min, max)).clamp(min, max)
          : context.responsiveValue(min, max),
    );
  }
}
