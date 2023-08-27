import 'package:flutter/material.dart';
import 'package:kindblood/features/contacts_list/domain/entities/blood_compatibility_info.dart';
import '../../domain/entities/blood_group.dart';
import 'blood_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/routing/routes.dart';
import 'location_icon.dart';

class ContactListTile extends StatelessWidget {
  final int index;
  final String name;
  final String phone;
  final BloodGroup? bloodGroup;
  final double? distanceInKm;

  const ContactListTile(
      {super.key,
      required this.index,
      required this.name,
      required this.phone,
      this.bloodGroup,
      this.distanceInKm});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListingCubit, ContactListingState>(
      builder: (context, state) {
        return ListTile(
          title: Hero(
            tag: "$phone-$name-name",
            child: Material(
              type: MaterialType.transparency,
              child: Text(name),
            ),
          ),
          subtitle: Text(phone),
          trailing: BloodIcon(
            bloodCompatibility: BloodCompatibility.compatibleDifferent,
            bloodGroup: bloodGroup ?? BloodGroup.Unknown,
          ),
          leading: LocationIcon(distanceInKm: distanceInKm),
          onTap: () {
            context.push(
              "/${Routes.contactViewScreen}",
              // Routes.contactViewScreen,
              extra: index,
            );
          },
        );
      },
    );
  }
}
