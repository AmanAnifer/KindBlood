import 'package:kindblood_common/core_entities.dart';

LengthUnit getOptimalViewingLengthUnit({required LengthUnit distance}) {
  if (distance.lengthInMeters > 1000) {
    return KiloMeter(value: distance.lengthInMeters / 1000);
  } else {
    return distance;
  }
}
