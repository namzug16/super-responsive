import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:super_responsive/super_responsive.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.breakPoints.first,
      height: context.responsiveValue(60, 80),
      color: ColorsTheme.white,
      child: ResponsiveLayout(
        layoutCount: 2,
        children: const [
          Title(),
          NavbarButtons(),
          NavbarIcon(),
        ],
        breakPoints: (_breakPoints) => _breakPoints.extremes,
        layouts: [
          FlexLayout.row(children: [0, 1]),
          FlexLayout.row(children: [0, 2]),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ResponsiveText(
            text: "Super Responsive",
            fontSizeRange: Range(20, 30),
            style: TextStyle(
              color: ColorsTheme.background,
            ),
          ),
        ),
      ),
    );
  }
}

class NavbarButtons extends StatelessWidget {
  const NavbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          NavbarButton(text: "home"),
          NavbarButton(text: "examples"),
          NavbarButton(text: "info"),
          NavbarButton(text: "contact"),
          NavbarButton(text: "blog"),
        ],
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  const NavbarButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.responsiveValue(10, 20)),
      child: TextButton(
        onPressed: () => context.go("/" + text),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: ColorsTheme.background,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class NavbarIcon extends StatelessWidget {
  const NavbarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(Icons.menu),
        splashRadius: 20,
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsTheme.white,
      child: Center(
        child: Column(children: const [
          NavbarButton(text: "home"),
          NavbarButton(text: "examples"),
          NavbarButton(text: "info"),
          NavbarButton(text: "contact"),
          NavbarButton(text: "blog"),
        ]),
      ),
    );
  }
}
