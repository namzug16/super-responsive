import 'package:super_responsive/src/range.dart';

///
int indexBreakPoint(double width, List<double> breakpoints) {
  final ranges = _getRangesFromBreakPoints(breakpoints);

  for (final range in ranges) {
    if (range.inside(width)) return breakpoints.indexOf(range.max);
  }
  return 0;
}

List<Range> _getRangesFromBreakPoints(List<double> breakpoints) {
  final List<Range> result = [];

  for (var i = 0; i < breakpoints.length; i++) {
    if (i == breakpoints.length - 1) {
      result.add(Range(0, breakpoints[i]));
    } else {
      result.add(Range(breakpoints[i + 1], breakpoints[i]));
    }
  }

  return result;
}
