import 'package:flutter/material.dart';
import 'package:kindblood/core/entities/blood_compatibility_info.dart';
import '../../../../core/entities/blood_group.dart';
import '../../../../core/widgets/blood_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/routing/routes.dart';
import '../../../../core/widgets/location_icon.dart';

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
          trailing: SizedBox(
            width: 50,
            child: BloodIcon(
              bloodCompatibility: BloodCompatibility.compatibleDifferent,
              bloodGroup: bloodGroup ?? BloodGroup.Unknown,
            ),
          ),
          leading: LocationIcon(distanceInKm: distanceInKm),
          onTap: () {
            context.push(
              "/${Routes.contactViewScreen}",
              // Routes.contactViewScreen,
              extra: (
                index,
                context.read<ContactListingCubit>(),
              ),
            );
          },
        );
      },
    );
  }
}
