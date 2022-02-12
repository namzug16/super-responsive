import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';

class ResponsiveGap extends StatelessWidget {
 const ResponsiveGap(this.min, this.max, {Key? key,}) : super(key: key);

  final double max;
  final double min;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: context.responsiveValue(min, max),
    );
  }
}

