import 'package:flutter/material.dart' hide Page;
import 'package:flutter_responsive_website/src/pages/home_page/avatar_section.dart';
import 'package:flutter_responsive_website/src/pages/home_page/content_section.dart';
import 'package:flutter_responsive_website/src/pages/home_page/first_section.dart';
import 'package:flutter_responsive_website/src/pages/page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page(
      child: Column(
        children: const [
          FirstSection(),
          ContentSection(),
          AvatarSection(),
          SizedBox.square(dimension: 100)
        ],
      ),
    );
  }
}

