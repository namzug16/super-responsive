import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/content_section.dart';
import 'package:flutter_responsive_website/src/first_section.dart';
import 'package:flutter_responsive_website/src/navbar.dart';
import 'package:flutter_responsive_website/src/theme.dart';
import 'package:google_fonts/google_fonts.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: GoogleFonts.sourceSerifProTextTheme(
            Theme.of(context).textTheme,
          )),
      home: SuperResponsive(
        breakPoints: BreakPoints(
          first: 1200,
          second: 900,
          third: 600,
        ),
        child: const MyHome(),
      ),
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
      backgroundColor: ColorsTheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Navbar(),
              FirstSection(),
              ContentSection(),
            ],
          ),
        ),
      ),
    );
  }
}
