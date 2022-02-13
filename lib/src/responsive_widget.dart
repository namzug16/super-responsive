import 'package:flutter/material.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

/// Returns a widget form [children] based on the current break point.
///
/// If [breakPoints] is not specified, the widget will use the global
/// breakPoints from the closest [SuperResponsive] widget.
///
/// if [followsScreenWidth] is set to false, it will use the
/// available space for the widget to find the current break
/// point from its [breakPoints], or the global breakPoints from
/// [SuperResponsive] if they are not specified.
class ResponsiveWidget extends StatelessWidget {

  /// Creates an instance of [ResponsiveWidget]
  const ResponsiveWidget({
    Key? key,
    required this.children,
    this.breakPoints,
    this.followsScreenWidth = true,
  }) : super(key: key);

  /// Widgets that will be used in the build method
  final List<Widget> children;

  /// Break points for this specific widget
  final BreakPoints? breakPoints;

  /// If set to false, the widget will find the current
  /// break point from the available space.
  ///
  /// If [breakPoints] have not been specified (meaning the variable
  /// is null) and [followsScreenWidth] is set to false, it might caused
  /// an undesired behaviour
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
