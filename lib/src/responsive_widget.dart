import 'package:flutter/material.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

/// Returns a widget form [children] based on the current break point.
///
/// If [breakpoints] is not specified, the widget will use the global
/// breakpoints from the closest [SuperResponsive] widget.
///
/// if [followsScreenWidth] is set to false, it will use the
/// available space for the widget to find the current break
/// point from its [breakpoints], or the global breakpoints from
/// [SuperResponsive] if they are not specified.
class ResponsiveWidget extends StatelessWidget {
  /// Creates an instance of [ResponsiveWidget]
  const ResponsiveWidget({
    Key? key,
    required this.children,
    this.breakpoints,
    this.followsScreenWidth = true,
  }) : super(key: key);

  /// Widgets that will be used in the build method
  final List<Widget> children;

  /// Break points for this specific widget
  final Breakpoints? breakpoints;

  /// If set to false, the widget will find the current
  /// break point from the available space.
  ///
  /// If [breakpoints] have not been specified (meaning the variable
  /// is null) and [followsScreenWidth] is set to false, it might caused
  /// an undesired behaviour
  final bool followsScreenWidth;

  @override
  Widget build(BuildContext context) {
    final List<double> _breakpoints =
        breakpoints?.list ?? context.breakpoints.list;
    assert(breakpoints!.list.length == children.length,
        "Amount of Break Points must be equal to the amount of children in ResponsiveWidget");

    return LayoutBuilder(builder: (context, constraints) {
      final double width = followsScreenWidth
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;
      final index = indexBreakPoint(width, _breakpoints);

      return children[index];
    });
  }
}
