import 'package:flutter/widgets.dart';
import 'package:super_responsive/src/exposed_utils.dart';
import 'package:super_responsive/src/responsive_percentage_value.dart';
import 'package:super_responsive/src/super_responsive.dart';

/// A util widget that calculates the font size of a text based
/// on the given range [fontSizeRange] and the global breakpoints.
///
/// if [maxWidthWrapper] is specified, the new font size value will be
/// calculated from the mapped value of the screen width between the range 0 -
/// [maxWidthWrapper] and the range [fontSizeRange].
///
/// if [textBreakpoints] are specified the font size will take those values
/// instead of continuously calculating new values. For example let's take
/// the range 20 - 30
/// and the [textBreakpoints] - [30, 17, 20] --- when the calculated value is
/// equal to 15 between the range 20 - 30, it will actually return 17, as is
/// the closest value from the [textBreakpoints]
///
class ResponsiveText extends StatelessWidget {
  /// Creates a new instance of [ResponsiveText]
  const ResponsiveText({
    Key? key,
    required this.text,
    required this.fontSizeRange,
    this.maxWidthWrapper,
    this.textBreakpoints,
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

  ///
  final String text;

  /// if [maxWidthWrapper] is specified, the new font size value will be
  /// calculated from the mapped value of the screen width between the range 0 -
  /// [maxWidthWrapper] and the range [fontSizeRange].
  final double? maxWidthWrapper;

  ///

  final Range fontSizeRange;

  /// if [textBreakpoints] are specified the font size will take those values
  /// instead of continuously calculating new values. For example let's take
  /// the range 20 - 30
  /// and the [textBreakpoints] - [30, 17, 20] --- when the calculated value is
  /// equal to 15 between the range 20 - 30, it will actually return 17, as is
  /// the closest value from the [textBreakpoints]
  final List<double>? textBreakpoints;

  ///

  final TextStyle? style;

  ///

  final StrutStyle? strutStyle;

  ///

  final TextAlign? textAlign;

  ///

  final TextDirection? textDirection;

  ///

  final Locale? locale;

  ///

  final bool? softWrap;

  ///

  final TextOverflow? overflow;

  ///

  final double? textScaleFactor;

  ///

  final int? maxLines;

  ///

  final String? semanticsLabel;

  ///

  final TextWidthBasis? textWidthBasis;

  ///

  final TextHeightBehavior? textHeightBehavior;

  double _fontSize(double value) {
    if (textBreakpoints == null) return value;

    return textBreakpoints!.reduce((_value, element) {
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
          maxWidthWrapper == null
              ? context.responsiveValue(fontSizeRange.min, fontSizeRange.max)
          // TODO refactor responsive text logic
              : mapValue(
                  constraints.maxWidth,
                  0,
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
