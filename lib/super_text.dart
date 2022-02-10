import 'package:flutter/widgets.dart';
import 'package:super_responsive/super_value.dart';
import 'package:super_responsive/utils.dart';

class SuperText extends StatelessWidget {
  const SuperText({
    Key? key,
    required this.text,
    required this.fontSizeRange,
    this.breakPoints,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  final String text;
  final Range fontSizeRange;
  final List<double>? breakPoints;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  double _fontSize(double value) {
    if (breakPoints == null) return value;

    return breakPoints!
        .reduce((value, element) => value < element ? value : element);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = _fontSize(mapValue(
          constraints.maxWidth,
          0.0,
          constraints.maxWidth,
          fontSizeRange.start,
          fontSizeRange.end,
        ));

        final _style = style?.copyWith(fontSize: fontSize) ??
            TextStyle(fontSize: fontSize);

        return Text(
          text,
          style: _style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );
      },
    );
  }
}
