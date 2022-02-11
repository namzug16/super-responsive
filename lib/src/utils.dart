int indexBreakPoint(double width, List<double> breakPoints) {
  for (final breakPoint in breakPoints.reversed) {
    if (width - breakPoint < 0) return breakPoints.indexOf(breakPoint);
  }
  return 0;
}
