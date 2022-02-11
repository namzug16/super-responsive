import 'package:flutter/material.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.children,
    this.breakPoints,
    this.followsScreenWidth = true,
  }) : super(key: key);

  final List<Widget> children;
  final BreakPoints? breakPoints;
  final bool followsScreenWidth;

  @override
  Widget build(BuildContext context) {
    if (breakPoints != null) {
      assert(breakPoints!.list.length == children.length,
          "Amount of Break Points must be equal to the amount of children in ResponsiveWidget");
    }

    return LayoutBuilder(builder: (context, constraints) {
      final double width = followsScreenWidth
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;
      final List<double> _breakPoints =
          breakPoints?.list ?? context.breakPoints.list;
      final index = indexBreakPoint(width, _breakPoints);

      return children[index];
    });
  }
}
