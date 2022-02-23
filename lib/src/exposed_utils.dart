import 'package:super_responsive/src/range.dart';

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

/// Return a percentage value -> limit * valuePercentage%
/// and it clamps it to a respective [valueRange] if given.
///
/// This function is used in the [PercentageValueBuilder] widget and in the [PercentageContext] extensions
double responsivePercentageValue({
  required double valuePercentage,
  required Range? valueRange,
  required double limit,
}) {
  assert(valuePercentage >= 0 && valuePercentage <= 100,
  "Value percentage must be between 0 and 100");

  if (valueRange == null) {
    return (valuePercentage / 100) * limit;
  }

  return (limit * valuePercentage / 100).clamp(valueRange.max, valueRange.min);
}