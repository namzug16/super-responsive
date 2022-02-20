import 'package:flutter/material.dart';
import 'package:super_responsive/super_responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperResponsive(
      breakpoints: Breakpoints(
        first: 1100,
        second: 1000,
        third: 900,
        fourth: 800,
      ),
      child: MaterialApp(
        title: 'Super Responsive Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(15),
          ),

          /// responsive value example
          /// the width will be the result from the mapped range
          /// [breakpoints.last - breakpoints.first] -> screen width
          /// [300 - 600] -> our final value
          width: context.responsiveValue(300, 600),
          height: context.mediaQueryHeight * 0.7,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        "MediaQuery.of(context).size.width: ${context.mediaQueryWidth}"),
                    Text(
                        "MediaQuery.of(context).size.height: ${context.mediaQueryHeight}"),
                    Text(
                        "Responsive Value (300, 600): ${context.responsiveValue(300, 600)}"),
                    Text("Breakpoints: ${context.breakpoints.list}"),
                    Text("Current breakpoint: ${context.currentBreakPoint}"),
                    Text(
                        "Custom breakpoints range responsive value: ${context.customResponsiveValue(
                      breakpointsRange: (_) => Range(500, 1000),
                      valueRange: Range(100, 200),
                    )}"),
                    Text(
                        "Custom value when current breakpoint: ${context.whenBreakpoints(
                      first: (_) => 1,
                      second: (_) => 2,
                      third: (_) => 3,
                      fourth: (_) => 4,
                    )}"),
                    Text("When custom breakpoints: ${Breakpoints(
                      first: 1000,
                      second: 900,
                      third: 800,
                      fourth: 700,
                    ).when(
                      maxWidth: context.mediaQueryWidth,
                      first: (bp) => 1,
                      second: (bp) => 2,
                      third: (bp) => 3,
                      fourth: (bp) => 4,
                      /// there is no fifth breakpoints
                      /// therefore this value will never
                      /// be reached
                      fifth: (bp) => 5,
                    )}"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
