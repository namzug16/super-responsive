import 'package:super_responsive/src/utils.dart' as utils;

extension MapValue on double {
  double lerp(
    double min,
    double max,
  ) {
    assert(this >= 0 && this <= 1.0);

    return utils.lerp(this, min, max);
  }

  double inverseLerp(double min, double max) =>
      utils.inverseLerp(this, min, max);
}
