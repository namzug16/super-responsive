import 'package:flutter/material.dart';
import 'package:super_responsive/super_responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.pink,
                  width: 100,
                  height: 100,
                ),
                Expanded(
                    child: Container(
                      color: Colors.yellow,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ResponsiveLayout(
        layoutCount: 4,
        children: const [
          BoxText(color: Colors.redAccent, text: "HELLOOOOOO"),
          Align(alignment: Alignment.bottomCenter ,child: Box(color: Colors.greenAccent, text: "1")),
          SuperValueTest(),
          Box(color: Colors.yellow, text: "3"),
        ],
        breakPoints: const [
          Size(1200, 900),
          Size(900, 900),
          Size(600, 1000),
          Size(500, 500),
        ],
        childrenFlexOnBreakPoints: const [
          [],
          [1, 2, 1],
          [2, 1, 1],
          [],
        ],
        childrenMaxSizes: const [
          null,
          Size(200, 200),
          null,
          null
        ],
        layouts: [
          MultiFlexLayout.row(
            children: [
              MultiFlexLayout.column(
                children: [
                  FlexLayout.row(
                    mainAxisSize: MainAxisSize.min,
                    children: [0, 3],
                  ),
                  SingleFlexLayout(1),
                ],
              ),
              SingleFlexLayout(2),
            ],
          ),
          MultiFlexLayout.column(
            childrenFlex: [],
            children: [
              FlexLayout.row(children: [1, 2]),
              SingleFlexLayout(0),
            ],
          ),
          FlexLayout.column(children: [1, 0, 2]),
          SingleFlexLayout(3)
        ],
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }
}

class BoxText extends StatelessWidget {
  const BoxText({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: ResponsiveText(
          text: text,
          maxWidth: 1000,
          fontSizeRange: Range(20, 90),
        ),
      ),
    );
  }
}

class SuperValueTest extends StatelessWidget {
  const SuperValueTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      responsiveValueBuilder: (_, __, superValueWidth, superValueHeight) {
        return Container(
          color: Colors.lightBlue,
          width: superValueWidth(80),
          height: superValueHeight(80),
        );
      },
    );
  }
}
