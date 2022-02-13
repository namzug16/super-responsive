import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/navbar.dart';
import 'package:flutter_responsive_website/src/theme.dart';

class Page extends StatelessWidget {
  const Page({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.background,
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:[
              const Navbar(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

