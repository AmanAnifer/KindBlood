import '../../features/contacts_list/domain/entities/blood_group.dart';

String getBloodGroupAcronym(BloodGroup? bloodGroup) {
  switch (bloodGroup) {
    case BloodGroup.ABNegative:
      return "AB -ve";
    case BloodGroup.ABPositive:
      return "AB +ve";
    case BloodGroup.ANegative:
      return "A -ve";
    case BloodGroup.APositive:
      return "A +ve";
    case BloodGroup.BNegative:
      return "B -ve";
    case BloodGroup.BPositive:
      return "B +ve";
    case BloodGroup.ONegative:
      return "O -ve";
    case BloodGroup.OPositive:
      return "O +ve";
    case BloodGroup.Other:
      return "Other";
    case BloodGroup.Unknown:
    case null:
      return "?";
  }
}
