import 'package:flutter/material.dart' hide Page;
import 'package:flutter_responsive_website/src/pages/example_page/examples/layout.dart';
import 'package:flutter_responsive_website/src/pages/page.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:super_responsive/super_responsive.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key, required this.example}) : super(key: key);

  final String example;

  @override
  Widget build(BuildContext context) {
    Widget _getExample(String example) {
      switch (example) {
        case "examples":
          return const ExampleList();
        case "layout":
          return const ExampleLayout();
      }
      return const SizedBox();
    }

    return Page(
      child: SizedBox(
        height: 700,
        width: context.currentBreakPoint,
        child: _getExample(example),
      ),
    );
  }
}

class ExampleList extends StatelessWidget {
  const ExampleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(children: const [
        ExampleListButton(example: "layout"),
      ]),
    );
  }
}

class ExampleListButton extends StatelessWidget {
  const ExampleListButton({Key? key, required this.example}) : super(key: key);

  final String example;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorsTheme.pink),
      ),
      onPressed: () => context.go("/examples/$example"),
      child: Text(example,
          style: TextStyle(
            color: ColorsTheme.white,
          )),
    );
  }
}
