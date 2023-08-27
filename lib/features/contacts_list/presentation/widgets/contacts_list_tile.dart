import 'package:flutter/material.dart';
import '../../../../core/entities/blood_group.dart';
import '../../../../core/widgets/blood_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/routing/routes.dart';
import '../../../../core/widgets/location_icon.dart';
import '../cubit/filter_widgets/filter_cubit.dart';

class ContactListTile extends StatelessWidget {
  // final int index;
  // final String name;
  // final String phone;
  // final BloodGroup? bloodGroup;
  // final bci.BloodCompatibility? bloodCompatibility;
  // final LengthUnit? distance;
  final DisplayContactInfo displayContactInfo;
  // const ContactListTile({
  //   super.key,
  //   required this.index,
  //   required this.name,
  //   required this.phone,
  //   this.bloodGroup,
  //   this.bloodCompatibility = const bci.Incompatible(),
  //   this.distance,
  // });
  const ContactListTile({
    super.key,
    required this.displayContactInfo,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListingCubit, ContactListingState>(
      builder: (context, state) {
        return ListTile(
          title: Hero(
            tag: "${displayContactInfo.phone}-${displayContactInfo.name}-name",
            child: Material(
              type: MaterialType.transparency,
              child: Text(displayContactInfo.name),
            ),
          ),
          subtitle: Text(displayContactInfo.phone),
          trailing: SizedBox(
            width: 50,
            child: BloodIcon(
              bloodCompatibility: displayContactInfo.bloodCompatibility,
              bloodGroup: displayContactInfo.bloodGroup ?? BloodGroup.Unknown,
            ),
          ),
          leading: LocationIcon(distance: displayContactInfo.distanceFromUser),
          onTap: () {
            context.push(
              "/${Routes.contactViewScreen}",
              // Routes.contactViewScreen,
              extra: (
                displayContactInfo,
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
