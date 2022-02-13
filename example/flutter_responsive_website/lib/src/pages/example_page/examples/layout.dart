import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:super_responsive/super_responsive.dart';

class ExampleLayout extends StatelessWidget {
  const ExampleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      layoutCount: 1,
      children: [
        Box(ColorsTheme.pink, "one"),
        Box(ColorsTheme.pinkAccent, "two"),
        Box(ColorsTheme.white, "three"),
        const Box(Colors.tealAccent, "fourth"),
        const Box(Colors.deepPurpleAccent, "fifth"),
        const Box(Colors.orangeAccent, "?"),
      ],
      breakPoints: (bp) => [
        1200,
        // 1100,
        // 1000,
        // 900,
        // 800,
      ],
      layouts: [
        MultiFlexLayout.column(
          children: [
            FlexLayout.row(children: [0, 1]),
            MultiFlexLayout.row(
              children: [
                FlexLayout.column(children: [2, 3]),
                SingleFlexLayout(4),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  const Box(this.color, this.text, {Key? key}) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: ColorsTheme.background,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
