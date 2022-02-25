import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_responsive/src/breakpoints.dart';
import 'package:super_responsive/src/super_responsive.dart';

void setScreenSize(WidgetTester tester, Size size) {
  tester.binding.window.physicalSizeTestValue = size;
  tester.binding.window.devicePixelRatioTestValue = 1;
}

class ContextTest {
  ContextTest({
    required this.widget,
    required this.context,
  });

  final Widget widget;
  final BuildContext context;
}

void main() {
  group("Super Responsive Widget", () {
    Future<ContextTest> _getWidget(WidgetTester tester) async {
      late BuildContext _context;
      Widget widget = MaterialApp(
        home: SuperResponsive(
          breakpoints: Breakpoints(
            first: 1000,
            second: 500,
          ),
          child: Scaffold(
            body: Builder(builder: (context) {
              _context = context;
              return Container();
            }),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pump();

      return ContextTest(
        widget: tester.widget(find.byType(SuperResponsive)),
        context: _context,
      );
    }

    testWidgets("access break points", (WidgetTester tester) async {
      final ContextTest ct = await _getWidget(tester);
      final SuperResponsive superResponsive = ct.widget as SuperResponsive;

      expect(superResponsive.breakpoints.first, 1000);
      expect(superResponsive.breakpoints.second, 500);
      expect(superResponsive.breakpoints.third, null);
      expect(superResponsive.breakpoints.last, 500);
      expect(superResponsive.breakpoints.list.length, 2);
      expect(superResponsive.breakpoints.extremes[0], 1000);
      expect(superResponsive.breakpoints.extremes[1], 500);
      // test current break point without media query
      expect(superResponsive.breakpoints.currentBreakPoint(1300), 1000);
      expect(superResponsive.breakpoints.currentBreakPoint(900), 1000);
      expect(superResponsive.breakpoints.currentBreakPoint(400), 500);
      expect(superResponsive.breakpoints.currentBreakPoint(100), 500);
    });

    testWidgets("current break point based on screen size",
        (WidgetTester tester) async {
      setScreenSize(tester, const Size(1000, 1000));

      ContextTest ct = await _getWidget(tester);
      SuperResponsive superResponsive = ct.widget as SuperResponsive;
      BuildContext context = ct.context;

      double width = MediaQuery.of(context).size.width;

      expect(width, 1000);
      expect(superResponsive.breakpoints.currentBreakPoint(width), 1000);

      setScreenSize(tester, const Size(400, 1000));

      ct = await _getWidget(tester);
      superResponsive = ct.widget as SuperResponsive;
      context = ct.context;
      width = MediaQuery.of(context).size.width;

      expect(width, 400);
      expect(superResponsive.breakpoints.currentBreakPoint(width), 500);
    });
  });
}
