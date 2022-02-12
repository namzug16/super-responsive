import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/responsive_value.dart';
import 'package:super_responsive/src/super_responsive.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText({
    Key? key,
    required this.text,
    required this.fontSizeRange,
    this.maxWidthWrapper,
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
  final double? maxWidthWrapper;
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

    return breakPoints!.reduce((_value, element) {
      _value < element ? _value : element;
      final double v1 = (value - _value).abs();
      final double v2 = (value - element).abs();

      if (v2 <= v1) return element;
      return _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = _fontSize(
          maxWidthWrapper == null ?

           context.responsiveValue(fontSizeRange.min, fontSizeRange.max) :

          mapValue(
            constraints.maxWidth,
            0.0,
            maxWidthWrapper!,
            fontSizeRange.max,
            fontSizeRange.min,
          ),
        );

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
