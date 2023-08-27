import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_view/contact_view_cubit.dart';
import '../cubit/filter_widgets/filter_cubit.dart';
import '../../injection_container.dart';
import '../../../../core/widgets/blood_icon.dart';
import '../../../../core/widgets/select_blood_group.dart' as blood_select;
import '../../../../core/widgets/location_icon.dart';
import '../../domain/entities/search_filters.dart';

class ContactViewPage extends StatefulWidget {
  final int contactIndex;
  final ContactListingCubit _contactListingCubit;
  final FilterCubit _filterCubit;
  ContactViewPage({
    super.key,
    required (int, ContactListingCubit, FilterCubit) args,
  })  : contactIndex = args.$1,
        _contactListingCubit = args.$2,
        _filterCubit = args.$3;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget._contactListingCubit),
        BlocProvider.value(value: widget._filterCubit),
      ],
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
              var distanceFromUser = localContactListingState
                  .contactsList[widget.contactIndex].distanceFromUser;
              var locationGeoHash = localContactListingState
                  .contactsList[widget.contactIndex].locationGeohash;
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
                                  editedLocationGeoHash: locationGeoHash,
                                );
                          } else if (localContactViewState is ContactViewEdit) {
                            context
                                .read<ContactListingCubit>()
                                .updateContactInfo(
                                  phoneNumber: phone,
                                  bloodGroup:
                                      localContactViewState.editedBloodGroup,
                                  locationGeoHash: localContactViewState
                                      .editedlocationGeoHash,
                                );
                            context.read<ContactViewCubit>().endEdit();
                            context
                                .read<ContactListingCubit>()
                                .populateContacts(
                                  searchFilter: SearchFilter(
                                    contactSearchMode:
                                        ContactSearchMode.offline,
                                    bloodGroup: context
                                        .read<FilterCubit>()
                                        .state
                                        .bloodGroup,
                                  ),
                                );
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
                                    var selected = await blood_select
                                        .bloodTypeSelectDialogBuilder(context);
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
                            distance: localContactListingState
                                .contactsList[widget.contactIndex]
                                .distanceFromUser,
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
                        child: IconButton.filled(
                          // iconSize: 40,
                          onPressed: () {
                            context.read<ContactViewCubit>().callNumber(phone);
                          },
                          icon: const Icon(
                            Icons.phone,
                            size: 50,
                          ),
                        ),
                      ),
                      const Spacer(flex: 2)
                    ],
                  )),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
              // return ErrorWidget.withDetails(
              //   message: localContactListingState.toString(),
              // );
            }
          },
        ),
      ),
    );
  }
}
