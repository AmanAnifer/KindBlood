import 'package:flutter/material.dart';
import 'package:kindblood_common/core_entities.dart';
import '../utils/blood_group_acronym.dart';

class BloodIcon extends StatelessWidget {
  final BloodGroup? bloodGroup;
  final BloodCompatibility bloodCompatibility;
  final bool isLargeIcon;
  const BloodIcon({
    super.key,
    this.bloodGroup,
    BloodCompatibility? bloodCompatibility,
    this.isLargeIcon = false,
  }) : bloodCompatibility = bloodCompatibility ?? const Incompatible();

  Color get getBloodCompatibilityColor {
    switch (bloodCompatibility) {
      case CompatibleSame():
        return Colors.yellow.shade700;
      case CompatibleButDifferent():
      case Compatible():
        return Colors.red.shade700;
      case Incompatible():
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
