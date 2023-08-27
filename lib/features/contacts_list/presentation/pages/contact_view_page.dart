import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kindblood/features/contacts_list/domain/entities/blood_group.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_view/contact_view_cubit.dart';
import '../../injection_container.dart';
import '../widgets/blood_icon.dart';
import '../widgets/location_icon.dart';

class ContactViewPage extends StatefulWidget {
  final int contactIndex;
  const ContactViewPage({
    super.key,
    required this.contactIndex,
  });

  @override
  State<ContactViewPage> createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ContactListingCubit>(),
      child: BlocProvider(
        create: (context) => sl<ContactViewCubit>(),
        child: Builder(
          builder: (context) {
            var localContactViewState = context.watch<ContactViewCubit>().state;
            var localContactListingState =
                context.watch<ContactListingCubit>().state;

            if (localContactListingState is ContactListingSuccess) {
              var name = localContactListingState
                  .contactsList[widget.contactIndex].name;
              var phone = localContactListingState
                  .contactsList[widget.contactIndex].phone;
              var bloodGroup = localContactListingState
                      .contactsList[widget.contactIndex].bloodGroup ??
                  BloodGroup.Unknown;
              var distanceInKm = localContactListingState
                  .contactsList[widget.contactIndex].distanceInKm;
              return Material(
                child: Scaffold(
                  appBar: AppBar(
                    actions: [
                      Visibility(
                        visible: localContactViewState is ContactViewReadOnly,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (localContactViewState is ContactViewReadOnly) {
                            context.read<ContactViewCubit>().editDetail(
                                  editedBloodGroup: bloodGroup,
                                  editedDistanceInKm: distanceInKm,
                                );
                          } else {
                            context.read<ContactViewCubit>().endEdit();
                          }
                        },
                        icon: Icon(
                          localContactViewState is ContactViewReadOnly
                              ? Icons.edit
                              : Icons.save,
                        ),
                      )
                    ],
                  ),
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: localContactViewState is ContactViewEdit
                                ? () async {
                                    var selected =
                                        await _bloodTypeSelectDialogBuilder(
                                            context);
                                    if (mounted) {
                                      context
                                          .read<ContactViewCubit>()
                                          .editDetail(
                                            editedBloodGroup:
                                                selected ?? bloodGroup,
                                          );
                                    }
                                  }
                                : null,
                            child: BloodIcon(
                              isLargeIcon: true,
                              bloodGroup:
                                  (localContactViewState is ContactViewEdit)
                                      ? localContactViewState.editedBloodGroup
                                      : bloodGroup,
                            ),
                          ),
                          LocationIcon(
                            isLargeIcon: true,
                            distanceInKm: localContactListingState
                                .contactsList[widget.contactIndex].distanceInKm,
                            // callback:
                            //     localContactViewState is ContactViewEdit
                            //         ? () {}
                            //         : null,
                          ),
                        ],
                      ),
                      const Spacer(flex: 1),
                      Hero(
                        tag: "$phone-$name-name",
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      Text(
                        phone,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(flex: 1),
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: localContactViewState is ContactViewReadOnly,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<ContactViewCubit>()
                                  .callNumber(phone);
                            },
                            icon: const Icon(
                              Icons.phone,
                              // size: 60,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 2)
                    ],
                  )),
                ),
              );
            } else {
              return ErrorWidget.withDetails(
                message: localContactListingState.toString(),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<BloodGroup?> _bloodTypeSelectDialogBuilder(BuildContext context) async {
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
