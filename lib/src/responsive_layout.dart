import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/super_responsive.dart';
import 'package:super_responsive/src/utils.dart';

enum FlexLayoutType {
  column,
  row,
}

abstract class BaseFlexLayout {
  Widget layout({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  });
}

class MultiFlexLayout extends BaseFlexLayout {
  MultiFlexLayout.column({
    this.key,
    required this.children,
    this.childrenFlex = const [],
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    this.textDirection,
    VerticalDirection? verticalDirection,
    this.textBaseline,
  })  : mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize = mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center,
        verticalDirection = verticalDirection ?? VerticalDirection.down,
        _type = FlexLayoutType.column;

  MultiFlexLayout.row({
    this.key,
    required this.children,
    this.childrenFlex = const [],
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    this.textDirection,
    VerticalDirection? verticalDirection,
    this.textBaseline,
  })  : mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize = mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center,
        verticalDirection = verticalDirection ?? VerticalDirection.down,
        _type = FlexLayoutType.row;

  final Key? key;
  final List<BaseFlexLayout> children;
  final List<int?> childrenFlex;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final FlexLayoutType _type;

  @override
  Widget layout({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  }) {
    switch (_type) {
      case FlexLayoutType.column:
        return Column(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          textDirection: textDirection,
          children: _getChildren(
            widgets: widgets,
            widgetsFlex: widgetsFlex,
          ),
        );
      case FlexLayoutType.row:
        return Row(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          textDirection: textDirection,
          children: _getChildren(
            widgets: widgets,
            widgetsFlex: widgetsFlex,
          ),
        );
    }
  }

  List<Widget> _getChildren({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  }) {
    if (childrenFlex.isNotEmpty) assert(childrenFlex.length == children.length);

    return [
      for (var i = 0; i < children.length; i++)
        if (childrenFlex.isNotEmpty && childrenFlex[i] == null)
          children[i].layout(
            widgets: widgets,
            widgetsFlex: widgetsFlex,
          )
        else
          Expanded(
            flex: childrenFlex.isEmpty ? 1 : childrenFlex[i]!,
            child: children[i].layout(
              widgets: widgets,
              widgetsFlex: widgetsFlex,
            ),
          )
    ];
  }
}

class FlexLayout extends BaseFlexLayout {
  FlexLayout.column({
    this.key,
    required this.children,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    this.textDirection,
    VerticalDirection? verticalDirection,
    this.textBaseline,
  })  : mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize = mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center,
        verticalDirection = verticalDirection ?? VerticalDirection.down,
        _type = FlexLayoutType.column;

  FlexLayout.row({
    this.key,
    required this.children,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    this.textDirection,
    VerticalDirection? verticalDirection,
    this.textBaseline,
  })  : mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize = mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center,
        verticalDirection = verticalDirection ?? VerticalDirection.down,
        _type = FlexLayoutType.row;

  final Key? key;
  final List<int> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final FlexLayoutType _type;

  @override
  Widget layout({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  }) {
    switch (_type) {
      case FlexLayoutType.column:
        return Column(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          textDirection: textDirection,
          children: _getChildren(
            widgets: widgets,
            widgetsFlex: widgetsFlex,
          ),
        );
      case FlexLayoutType.row:
        return Row(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          textDirection: textDirection,
          children: _getChildren(
            widgets: widgets,
            widgetsFlex: widgetsFlex,
          ),
        );
    }
  }

  List<Widget> _getChildren({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  }) {
    return [
      for (final child in children)
        if (widgetsFlex == null ||
            (widgetsFlex.isNotEmpty && widgetsFlex[child] == null))
          widgets[child]
        else
          Expanded(
            flex: widgetsFlex.isEmpty ? 1 : widgetsFlex[child]!,
            child: widgets[child],
          )
    ];
  }
}

class SingleFlexLayout extends BaseFlexLayout {
  SingleFlexLayout(this.child);

  final int child;

  @override
  Widget layout({
    required List<Widget> widgets,
    required List<int?>? widgetsFlex,
  }) {
    if (widgetsFlex != null &&
        widgetsFlex.isNotEmpty &&
        widgetsFlex.length > child) {
      return Expanded(
        flex: widgetsFlex[child]!,
        child: widgets[child],
      );
    }

    return widgets[child];
  }
}

typedef BreakPointsBuilder = List<double> Function(BreakPoints breakPoints);

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.layoutCount,
    required this.children,
    this.childrenFlexOnBreakPoints,
    required this.breakPoints,
    required this.layouts,
  })  : assert(layouts.length == layoutCount),
        super(key: key);

  final int layoutCount;
  final List<Widget> children;
  final BreakPointsBuilder breakPoints;
  final List<BaseFlexLayout> layouts;
  final List<List<int?>?>? childrenFlexOnBreakPoints;

  @override
  Widget build(BuildContext context) {

    final widgets = children;

    return LayoutBuilder(
      builder: (context, constraints) {
        final index = indexBreakPoint(
            constraints.maxWidth, breakPoints(context.breakPoints));
        final layout = layouts[index];
        final flex = childrenFlexOnBreakPoints?[index];

        return layout.layout(
          widgets: widgets,
          widgetsFlex: flex,
        );
      },
    );
  }
}
