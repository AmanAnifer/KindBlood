import 'package:flutter/material.dart';
import 'package:kindblood/core/entities/blood_compatibility_info.dart' as bci;
import 'package:kindblood/core/entities/length_units.dart';
import '../../../../core/entities/blood_group.dart';
import '../../../../core/widgets/blood_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/routing/routes.dart';
import '../../../../core/widgets/location_icon.dart';
import '../cubit/filter_widgets/filter_cubit.dart';

class ContactListTile extends StatelessWidget {
  final int index;
  final String name;
  final String phone;
  final BloodGroup? bloodGroup;
  final LengthUnit? distance;

  const ContactListTile({
    super.key,
    required this.index,
    required this.name,
    required this.phone,
    this.bloodGroup,
    this.distance,
  });

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
              // TODO: actual blood compatibility
              bloodCompatibility: bci.CompatibleButDifferent,
              bloodGroup: bloodGroup ?? BloodGroup.Unknown,
            ),
          ),
          leading: LocationIcon(distance: distance),
          onTap: () {
            context.push(
              "/${Routes.contactViewScreen}",
              // Routes.contactViewScreen,
              extra: (
                index,
                context.read<ContactListingCubit>(),
                context.read<FilterCubit>(),
              ),
            );
          },
        );
      },
    );
  }
}
