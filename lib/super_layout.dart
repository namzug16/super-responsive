import 'package:flutter/widgets.dart';

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
    this.childrenFlex,
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
    this.childrenFlex,
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
  final List<int?>? childrenFlex;
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
          children: [
            for (var i = 0; i < children.length; i++)
              if (childrenFlex == null ||
                  (childrenFlex != null && childrenFlex![i] == null))
                children[i].layout(widgets: widgets, widgetsFlex: widgetsFlex)
              else
                Expanded(
                  flex: childrenFlex![i]!,
                  child: Center(
                    child: children[i].layout(
                      widgets: widgets,
                      widgetsFlex: widgetsFlex,
                    ),
                  ),
                )
          ],
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
          children: [
            for (var i = 0; i < children.length; i++)
              if (childrenFlex == null ||
                  (childrenFlex != null && childrenFlex![i] == null))
                children[i].layout(widgets: widgets, widgetsFlex: widgetsFlex)
              else
                Expanded(
                  flex: childrenFlex![i]!,
                  child: Center(
                    child: children[i].layout(
                      widgets: widgets,
                      widgetsFlex: widgetsFlex,
                    ),
                  ),
                )
          ],
        );
    }
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
          children: [
            for (final child in children)
              if (widgetsFlex == null || widgetsFlex[child] == null)
                widgets[child]
              else
                Expanded(
                  flex: widgetsFlex[child]!,
                  child: Center(child: widgets[child]),
                )
          ],
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
          children: [
            for (final child in children)
              if (widgetsFlex == null || widgetsFlex[child] == null)
                widgets[child]
              else
                Expanded(
                  flex: widgetsFlex[child]!,
                  child: Center(child: widgets[child]),
                )
          ],
        );
    }
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
    return widgets[child];
  }
}

class SuperLayout extends StatelessWidget {
  const SuperLayout({
    Key? key,
    required this.layoutCount,
    required this.children,
    required this.breakPoints,
    required this.layouts,
    this.childrenFlex,
    this.childrenMaxSizes,
  })  : assert(breakPoints.length == layoutCount),
        assert(layouts.length == layoutCount),
        super(key: key);

  final int layoutCount;
  final List<Widget> children;
  final List<Size?>? childrenMaxSizes;
  final List<Size> breakPoints;
  final List<BaseFlexLayout> layouts;
  final List<List<int?>?>? childrenFlex;

  int _index(Size constraints) {

    final List<int> indexes = List.generate(breakPoints.length, (index) => index);

    return indexes.reduce((value, element){

      final Offset sDifference = (constraints - breakPoints[element]) as Offset;
      final double difference = (sDifference.dx + sDifference.dy).abs();

      final Offset valueSDifference = (constraints - breakPoints[value]) as Offset;
      final double valueDifference = (valueSDifference.dx + valueSDifference.dy).abs();

      if(difference < valueDifference) return element;

      return value;

    });

  }

  @override
  Widget build(BuildContext context) {
    final widgets = List<Widget>.generate(
      children.length,
      (i) => SizedBox(
        height: childrenMaxSizes?[i]?.height,
        width: childrenMaxSizes?[i]?.width,
        child: children[i],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final index = _index(constraints.biggest);
        final layout = layouts[index];
        final flex = childrenFlex?[index];

        return layout.layout(
          widgets: widgets,
          widgetsFlex: flex,
        );
      },
    );
  }
}
