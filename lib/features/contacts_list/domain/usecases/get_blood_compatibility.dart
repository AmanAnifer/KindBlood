import '../../../../core/entities/blood_group.dart';
import '../entities/blood_compatibility_info.dart';

BloodCompatibility getBloodCompatibility({
  required BloodGroup receiver,
  required BloodGroup donor,
}) {
  final List<BloodGroup> currentReceiverCompatibilityMap =
      bloodCanReceiveCompatibilityMap[receiver]!;
  if (currentReceiverCompatibilityMap.contains(donor)) {
    if (receiver == donor) {
      return BloodCompatibility.compatibleSame;
    } else {
      return BloodCompatibility.compatibleDifferent;
    }
  } else {
    return BloodCompatibility.incompatible;
  }
}

final bloodCanGiveCompatibilityMap = <BloodGroup, List<BloodGroup>>{
  BloodGroup.APositive: [
    BloodGroup.APositive,
    BloodGroup.ABPositive,
  ],
  BloodGroup.OPositive: [
    BloodGroup.OPositive,
    BloodGroup.APositive,
    BloodGroup.BPositive,
    BloodGroup.ABPositive,
  ],
  BloodGroup.BPositive: [
    BloodGroup.BPositive,
    BloodGroup.ABPositive,
  ],
  BloodGroup.ABPositive: [
    BloodGroup.ABPositive,
  ],
  BloodGroup.ANegative: [
    BloodGroup.APositive,
    BloodGroup.ANegative,
    BloodGroup.ABPositive,
    BloodGroup.ABNegative,
  ],
  BloodGroup.ONegative: BloodGroup.values
    ..remove(BloodGroup.Other), // Everyone except other special cases
  BloodGroup.BNegative: [
    BloodGroup.BPositive,
    BloodGroup.BNegative,
    BloodGroup.ABPositive,
    BloodGroup.ABNegative,
  ],
  BloodGroup.ABNegative: [
    BloodGroup.ABPositive,
    BloodGroup.ABNegative,
  ],
  BloodGroup.Other: [
    BloodGroup.Other,
  ],
  BloodGroup.Unknown: [],
};

final bloodCanReceiveCompatibilityMap = <BloodGroup, List<BloodGroup>>{
  BloodGroup.APositive: [
    BloodGroup.APositive,
    BloodGroup.ANegative,
    BloodGroup.OPositive,
    BloodGroup.ONegative,
  ],
  BloodGroup.OPositive: [
    BloodGroup.OPositive,
    BloodGroup.ONegative,
  ],
  BloodGroup.BPositive: [
    BloodGroup.BPositive,
    BloodGroup.BNegative,
    BloodGroup.OPositive,
    BloodGroup.ONegative,
  ],
  BloodGroup.ABPositive: BloodGroup.values
    ..remove(BloodGroup.Other), // Everyone except other special cases
  BloodGroup.ANegative: [
    BloodGroup.ANegative,
    BloodGroup.ONegative,
  ],
  BloodGroup.ONegative: [
    BloodGroup.ONegative,
  ],
  BloodGroup.BNegative: [
    BloodGroup.BNegative,
    BloodGroup.ONegative,
  ],
  BloodGroup.ABNegative: [
    BloodGroup.ABNegative,
    BloodGroup.ANegative,
    BloodGroup.BNegative,
    BloodGroup.ONegative,
  ],
  BloodGroup.Other: [
    BloodGroup.Other,
  ],
  BloodGroup.Unknown: [],
};
