import 'package:flutter/material.dart';
import '../entities/blood_compatibility_info.dart' as bci;
import '../entities/blood_group.dart';
import '../utils/blood_group_acronym.dart';

class BloodIcon extends StatelessWidget {
  final BloodGroup? bloodGroup;
  final bci.BloodCompatibility bloodCompatibility;
  final bool isLargeIcon;
  const BloodIcon({
    super.key,
    this.bloodGroup,
    bci.BloodCompatibility? bloodCompatibility,
    this.isLargeIcon = false,
  }) : bloodCompatibility = bloodCompatibility ?? const bci.Incompatible();

  Color get getBloodCompatibilityColor {
    switch (bloodCompatibility) {
      case bci.CompatibleSame():
        return Colors.yellow.shade700;
      case bci.CompatibleButDifferent():
      case bci.Compatible():
        return Colors.red.shade700;
      case bci.Incompatible():
        return Colors.grey;
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
          getBloodGroupAcronym(bloodGroup) ?? "?",
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
