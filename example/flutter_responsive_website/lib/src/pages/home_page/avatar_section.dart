import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:super_responsive/super_responsive.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.currentBreakPoint,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.responsiveValue(30, 100)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(color: ColorsTheme.pinkAccent, height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                child: ResponsiveLayout(
                  layoutCount: 2,
                  children: [
                    CircleAvatar(
                      radius: context.responsiveValue(60, 120),
                      backgroundColor: ColorsTheme.pink,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ResponsiveText(
                          text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          fontSizeRange: Range(15, 25),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorsTheme.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox.square(dimension: 30,)
                  ],
                  breakPoints: (bp) => bp.extremes,
                  childrenFlexOnBreakPoints: const [[], null],
                  layouts: [
                    FlexLayout.row(children: [0, 1]),
                    FlexLayout.column(children: [0, 2, 1]),
                  ],
                ),
              ),
            ),
            Divider(color: ColorsTheme.pinkAccent, height: 3),
          ],
        ),
      ),
    );
  }
}
