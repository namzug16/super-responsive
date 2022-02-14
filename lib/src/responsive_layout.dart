import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

/// A callback used in [ResponsiveLayout], it exposes the [breakpoints] of
/// the closest [SuperResponsive] widget in the widget tree.
typedef BreakpointsBuilder = List<double> Function(Breakpoints breakpoints);

/// A callback used in [ResponsiveLayout], it exposes a function called "child",
/// that accepts as an input and integer and return the child of that index
/// from [ResponsiveLayout.children].
typedef LayoutsBuilder = List<Widget> Function(Widget Function(int i) child);

/// A util class that builds a certain layout based on the current break point.
class ResponsiveLayout extends StatelessWidget {

  /// Creates a new instance of [ResponsiveLayout]
  const ResponsiveLayout({
    Key? key,
    required this.layoutCount,
    required this.children,
    required this.breakpoints,
    required this.layouts,
  })  : super(key: key);

  /// It represent the amount of layouts this widget will
  /// be able to process
  final int layoutCount;

  /// All the children that can be used in the [layouts]
  final List<Widget> children;

  /// A callback method that exposes the [breakpoints] of the closest
  /// [SuperResponsive] widget, so that it can be used if needed. For examples
  ///
  /// ```dart
  /// ...
  /// // the widget has only two possible layouts and uses the extremes as
  /// // break points
  /// breakpoints: (breakpoints) => breakpoints.extremes
  /// ...
  ///
  /// ...
  /// breakpoints: (_) => [1200, 900, 700, 500] // your custom break points for this widget
  /// ...
  ///
  /// ```
  ///
  final BreakpointsBuilder breakpoints;

  /// The layouts used in this widget.
  /// An specific layout is returned based on the current break point,
  /// you return any widget that you want here
  final LayoutsBuilder layouts;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final _breakpoints = breakpoints(context.breakpoints);
        assert(_breakpoints.length == layoutCount, "Amount of break points does not correspond to layoutCount");
        final index = indexBreakPoint(
            constraints.maxWidth, _breakpoints);

        final _layouts = layouts((i) => children[i]);

        assert(_layouts.length == layoutCount, "Amount of layouts does not correspond to layoutCount");

        return layouts((i) => children[i])[index];
      },
    );
  }
}

/// A util extension to wrap a [Row] in an expanded widget, for more readability
/// when making complex layouts with nested [Row]s and [Column]s
extension ExpandRow on Row{

  /// Wraps this [Row] in an [Expanded] widget, with an specific [flex],
  /// for a better readability when making complex layouts with nested [Row]s
  /// and [Column]s in a [ResponsiveLayout] widget.
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);

}

/// A util extension to wrap a [Column] in an expanded widget, for more readability
/// when making complex layouts with nested [Row]s and [Column]s
extension ExpandColumn on Column{

  /// Wraps this [Column] in an [Expanded] widget, with an specific [flex],
  /// for a better readability when making complex layouts with nested [Row]s
  /// and [Column]s in a [ResponsiveLayout] widget.
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);

}
