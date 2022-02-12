import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';

class ResponsiveGap extends StatelessWidget {
  const ResponsiveGap(
    this.min,
    this.max, {
    Key? key,
    this.reversed = false,
  }) : super(key: key);

  final double max;
  final double min;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: reversed
          ? max - context.responsiveValue(min, max)
          : context.responsiveValue(min, max),
    );
  }
}