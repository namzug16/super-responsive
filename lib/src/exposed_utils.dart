/// Re-maps a value from one range into another. That is, a [value] between the
/// range [minIn] - [maxIn] will be mapped to the range [minOut] - [maxOut],
/// the [value] will be clamped in case is not inside its range [minIn] - [maxIn]
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

/// Maps a value between its range [min] - [max] and 0.0 - 1.0
double lerp(double value, double min, double max) =>
    mapValue(value, min, max, 0.0, 0.1);

/// Maps a value between 0.0 - 1.0 to the range [min] - [max]
double inverseLerp(double value, double min, double max) =>
    mapValue(value, 0.0, 1.0, min, max);
