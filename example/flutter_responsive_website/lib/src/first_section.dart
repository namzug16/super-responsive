import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:super_responsive/super_responsive.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: ColorsTheme.background,
      fontWeight: FontWeight.w400,
    );

    const gap = ResponsiveGap(10, 25);

    return SizedBox(
        width: context.breakPoints.first,
        height: context.responsiveValue(400, 600),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/background.png", fit: BoxFit.cover),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ResponsiveGap(20, 60),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      text: "Super Responsive",
                      fontSizeRange: Range(40, 64),
                      style: style.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const ResponsiveGap(30, 45),
                    ResponsiveText(
                      text: "Responsive websites.",
                      fontSizeRange: Range(20, 36),
                      style: style,
                    ),
                    gap,
                    ResponsiveText(
                      text: "Responsive apps.",
                      fontSizeRange: Range(20, 36),
                      style: style,
                    ),
                    gap,
                    ResponsiveText(
                      text: "Made simple.",
                      fontSizeRange: Range(20, 36),
                      style: style,
                    ),
                    gap,
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorsTheme.pink),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                          EdgeInsets.all(context.responsiveValue(10, 20)),
                        ),
                      ),
                      onPressed: () {},
                      child: ResponsiveText(
                        text: "super-responsive",
                        fontSizeRange: Range(14, 25),
                        style: TextStyle(color: ColorsTheme.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
