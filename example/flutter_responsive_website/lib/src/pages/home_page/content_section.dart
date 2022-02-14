import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:super_responsive/super_responsive.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gap = ResponsiveGap(10, 30, reversed: true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ResponsiveGap(30, 80),
        ResponsiveText(
          text: "A different way to layout your widgets",
          fontSizeRange: Range(18, 45),
          style: TextStyle(color: ColorsTheme.white),
        ),
        gap,
        gap,
        const Section(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
          isLeft: true,
        ),
        gap,
        const Section(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
          isLeft: false,
        ),
        gap,
        const Section(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
          isLeft: true,
        ),
        gap,
      ],
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.text,
    required this.isLeft,
  }) : super(key: key);

  final bool isLeft;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.breakpoints.when(
          context: context,
          first: (_) => 550,
          second: (_) => context.responsiveValue(400, 750),
          third: (_) => 400),
      width: context.currentBreakPoint,
      child: ResponsiveLayout(
        breakpoints: (bp) => [bp.first, bp.second],
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ResponsiveText(
                  text: text,
                  fontSizeRange: Range(15, 25),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: ColorsTheme.white,
                  ),
                ),
              ),
            ),
          ),
          const ContentCard(),
        ],
        layoutCount: 2,
        layouts: (child) => [
          Row(children: isLeft ? [child(0), child(1)] : [child(1), child(0)]),
          Column(children: [child(1), child(0)]),
        ],
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  const ContentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox.square(
          dimension: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(context.responsiveValue(10, 15)),
                color: ColorsTheme.pinkAccent,
              ),
              child: SizedBox.square(
                dimension: context.responsiveValue(200, 400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
