/// A util class to write a range in a more readable way.
class Range {
  /// Creates an instance of [Range]
  Range(this.min, this.max);

  /// Maximum value of the range
  final double max;

  /// Minimum value of the range
  final double min;

  bool inside(double value) => value <= max && value >= min;

  @override
  String toString() {
    return "Range: ($min, $max)";
  }
}
