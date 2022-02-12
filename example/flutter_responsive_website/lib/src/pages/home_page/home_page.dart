import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/navbar.dart';
import 'package:flutter_responsive_website/src/pages/home_page/avatar_section.dart';
import 'package:flutter_responsive_website/src/pages/home_page/content_section.dart';
import 'package:flutter_responsive_website/src/pages/home_page/first_section.dart';
import 'package:flutter_responsive_website/src/theme.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              Navbar(),
              FirstSection(),
              ContentSection(),
              AvatarSection(),
              SizedBox.square(dimension: 100)
            ],
          ),
        ),
      ),
    );
  }
}

