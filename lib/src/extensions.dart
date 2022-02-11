import "package:super_responsive/src/exposed_utils.dart" as utils;

extension MapValue on double {

  double mapValue(
      double minIn,
      double maxIn,
      double minOut,
      double maxOut,
      ) => utils.mapValue(this, minIn, maxIn, minOut, maxOut);

}
