import 'package:kindblood_common/core_entities.dart';

String? getBloodGroupAcronym(BloodGroup? bloodGroup) {
  switch (bloodGroup) {
    case BloodGroup.APositive:
      return "A +ve";
    case BloodGroup.ANegative:
      return "A -ve";
    case BloodGroup.ABPositive:
      return "AB +ve";
    case BloodGroup.ABNegative:
      return "AB -ve";
    case BloodGroup.BPositive:
      return "B +ve";
    case BloodGroup.BNegative:
      return "B -ve";
    case BloodGroup.OPositive:
      return "O +ve";
    case BloodGroup.ONegative:
      return "O -ve";
    case BloodGroup.Other:
      return "Other";
    case null:
      return null;
    case BloodGroup.Unknown:
      return "?";
  }
}
