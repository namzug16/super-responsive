import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/pages/home_page/home_page.dart';
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
      title: 'Super Responsive',
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
        child: const HomePage(),
      ),
    );
  }
}