import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:super_responsive/super_responsive.dart';

class ExampleLayout extends StatelessWidget {
  const ExampleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      layoutCount: 5,
      children: [
        Box(ColorsTheme.pink, "zero"),
        Box(ColorsTheme.pinkAccent, "one", flex: 2),
        Box(ColorsTheme.white, "two"),
        const Box(Colors.tealAccent, "three"),
        const Box(Colors.deepPurpleAccent, "four"),
        const Box(Colors.orangeAccent, "?"),
        Box(ColorsTheme.pink, "zero - but different", flex: 2),
      ],
      breakPoints: (bp) => [
        1200,
        1100,
        1000,
        900,
        800,
      ],
      layouts: (child) => [
        Column(
          children: [
            Row(children: [child(0), child(1)]).expanded(),
            Row(
              children: [
                Column(children: [child(2), child(3)]).expanded(2),
                child(4),
              ],
            ).expanded()
          ],
        ),
        Column(
          children: [
            Row(children: [child(6), child(2)]).expanded(),
            Row(
              children: [
                Column(children: [child(2), child(3)]).expanded(),
                child(4),
              ],
            ).expanded()
          ],
        ),
        Row(
          children: [
            Column(children: [child(6), child(0)]).expanded(),
            Column(
              children: [
                Row(children: [child(2), child(3)]).expanded(),
                child(4),
              ],
            ).expanded()
          ],
        ),
        Column(
          children: [
            child(3),
            child(4),
          ],
        ),
        Column(
          children: [
            child(5),
          ],
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  const Box(this.color, this.text,  {Key? key, this.flex = 1}) : super(key: key);

  final Color color;
  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
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
