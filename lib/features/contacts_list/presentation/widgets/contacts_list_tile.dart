import 'package:flutter/material.dart';
import '../../domain/entities/blood_group.dart';

class ContactListTile extends StatelessWidget {
  final String name;
  final String phone;
  final BloodGroup? bloodGroup;
  final double? distanceInKm;

  const ContactListTile(
      {super.key,
      required this.name,
      required this.phone,
      this.bloodGroup,
      this.distanceInKm});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(phone),
      trailing:
          // Text(state.contactsList[index].bloodGroup.toString()),
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 30,
            Icons.water_drop,
            // color: Colors.redAccent.shade700,
            color: Colors.yellow.shade700,
          ),
          Text(
            // getBloodGroupAcronym(
            //   state.contactsList[index].bloodGroup,
            // ),
            "AB +ve",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      leading: Text(distanceInKm?.toString() ?? "? km"),
    );
  }
}
