import 'package:flutter/material.dart';
import '../entities/blood_compatibility_info.dart';
import '../entities/blood_group.dart';

class BloodIcon extends StatelessWidget {
  final BloodGroup? bloodGroup;
  final BloodCompatibility bloodCompatibility;
  final bool isLargeIcon;
  const BloodIcon({
    super.key,
    this.bloodGroup,
    this.bloodCompatibility = BloodCompatibility.incompatible,
    this.isLargeIcon = false,
  });

  Color get getBloodCompatibilityColor {
    switch (bloodCompatibility) {
      case BloodCompatibility.compatibleSame:
        return Colors.yellow.shade700;
      case BloodCompatibility.compatibleDifferent:
        return Colors.red.shade700;
      case BloodCompatibility.incompatible:
        return Colors.grey;
    }
  }

  String get getBloodGroupAcronym {
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
      case BloodGroup.Unknown:
        return "?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          size: isLargeIcon ? 60 : 30,
          Icons.water_drop,
          color: getBloodCompatibilityColor,
        ),
        // IconButton(

        //   iconSize: isLargeIcon ? 60 : 30,
        //   icon: const Icon(
        //     Icons.water_drop,
        //   ),
        //   onPressed: callback,
        //   color: getBloodCompatibilityColor,
        // ),
        Text(
          getBloodGroupAcronym,
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
