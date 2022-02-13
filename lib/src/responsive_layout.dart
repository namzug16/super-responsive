import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

typedef BreakPointsBuilder = List<double> Function(BreakPoints breakPoints);
typedef LayoutsBuilder = List<Widget> Function(Widget Function(int i) child);

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.layoutCount,
    required this.children,
    required this.breakPoints,
    required this.layouts,
  })  : super(key: key);

  final int layoutCount;
  final List<Widget> children;
  final BreakPointsBuilder breakPoints;
  final LayoutsBuilder layouts;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final _breakPoints = breakPoints(context.breakPoints);
        assert(_breakPoints.length == layoutCount, "Amount of break points does not correspond to layoutCount");
        final index = indexBreakPoint(
            constraints.maxWidth, _breakPoints);

        final _layouts = layouts((i) => children[i]);

        assert(_layouts.length == layoutCount, "Amount of layouts does not correspond to layoutCount");

        return layouts((i) => children[i])[index];
      },
    );
  }
}

extension ExpandRow on Row{

  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);

}

extension ExpandColumn on Column{

  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);

}
