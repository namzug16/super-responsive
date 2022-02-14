import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/pages/example_page/example_page.dart';
import 'package:flutter_responsive_website/src/pages/home_page/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_responsive/super_responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
        initialLocation: "/examples/layout",
        routes: [
          GoRoute(
            path: "/home",
            pageBuilder: (_, state) => NoTransitionPage(
              child: const HomePage(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: "/examples",
            pageBuilder: (_, state) => NoTransitionPage(
              child: const ExamplePage(example: "examples"),
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: ":id",
                pageBuilder: (_, state) => NoTransitionPage(
                  child: ExamplePage(example: state.params["id"]!),
                  key: state.pageKey,
                ),
              )
            ],
          ),
        ],
       );

    return SuperResponsive(
      breakpoints: Breakpoints(
        first: 1200,
        second: 900,
        third: 600,
      ),
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Super Responsive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: GoogleFonts.sourceSerifProTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    );
  }
}
