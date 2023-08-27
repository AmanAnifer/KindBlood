import 'package:flutter/material.dart';
import 'package:kindblood_common/core_entities.dart';

import 'blood_icon.dart';

Future<BloodGroup?> bloodTypeSelectDialogBuilder(BuildContext context) async {
  BloodGroup? selectedBloodGroup = await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: BloodGroup.values
              .map(
                (bloodGroup) => InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.of(context).pop(bloodGroup);
                  },
                  child: BloodIcon(
                    isLargeIcon: true,
                    bloodGroup: bloodGroup,
                  ),
                ),
              )
              .toList(),
        ),
      );
    },
  );
  return selectedBloodGroup;
}
