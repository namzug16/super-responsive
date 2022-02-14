///
int indexBreakPoint(double width, List<double> breakpoints) {
  for (final breakPoint in breakpoints.reversed) {
    if (width - breakPoint < 0) return breakpoints.indexOf(breakPoint);
  }
  return 0;
}
