double mapValue(
  double value,
  double minIn,
  double maxIn,
  double minOut,
  double maxOut,
) {
  assert(minIn < maxIn,
      "The minimum value of the given range must be less than its maximum value");
  assert(minOut < maxOut,
      "The minimum value of the given range must be less than its maximum value");

  double finalValue = value;

  if (value > maxIn) {
    finalValue = maxIn;
  } else if (value < minIn) {
    finalValue = minIn;
  }

  final double result =
      maxOut - ((maxIn - finalValue) / (maxIn - minIn)) * (maxOut - minOut);
  return result;
}

double lerp(double value, double min, double max) =>
    mapValue(value, min, max, 0.0, 0.1);

double inverseLerp(double value, double min, double max) =>
    mapValue(value, 0.0, 1.0, min, max);
