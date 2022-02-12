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
      children: const [
        gap,
        Section(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
          isLeft: true,
        ),
        gap,
        Section(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
          isLeft: false,
        ),
        gap,
        Section(
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
      height: context.breakPoints.when(
        context: context,
        first: (_) => 550,
        second: (_) => 600,
      ),
      width: context.currentBreakPoint,
      child: ResponsiveLayout(
        breakPoints: (bp) => [bp.first, bp.second],
        children: [
          Center(
            child: ResponsiveText(
              text: text,
              fontSizeRange: Range(15, 30),
              style: TextStyle(
                color: ColorsTheme.white,
              ),
            ),
          ),
          const ContentCard(),
        ],
        layoutCount: 2,
        childrenMaxSizes: const [Size(400, 400), null],
        childrenFlexOnBreakPoints: const [
          [],
          [],
        ],
        layouts: [
          FlexLayout.row(children: [0, 1]),
          FlexLayout.column(children: [1, 0]),
        ],
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  const ContentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.responsiveValue(10, 15)),
          color: ColorsTheme.pinkAccent,
        ),
        child: SizedBox.square(
          dimension: context.responsiveValue(200, 400),
        ),
      ),
    );
  }
}
