import 'package:flutter/material.dart';
import 'package:super_responsive/super_layout.dart';

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


// TODO make some samples
class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SuperLayout(
        layoutCount: 4,
        children: const [
          Box(color: Colors.redAccent, text: "0"),
          Box(color: Colors.greenAccent, text: "1"),
          Box(color: Colors.purpleAccent, text: "2"),
          Box(color: Colors.yellow, text: "3"),
        ],
        breakPoints: const [
          Size(1200, 900),
          Size(900, 900),
          Size(600, 1000),
          Size(500, 500),
        ],
        childrenFlex: const [
          null,
          [1, 2, null],
          [2, 1, 1],
          null
        ],
        childrenMaxSizes: const [
          Size(100, 100),
          null,
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
            childrenFlex: [1, 2],
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
