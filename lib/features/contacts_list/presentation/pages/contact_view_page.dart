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
  final DisplayContactInfo displayContactInfo;
  final ContactListingCubit _contactListingCubit;
  final FilterCubit _filterCubit;
  ContactViewPage({
    super.key,
    required (DisplayContactInfo, ContactListingCubit, FilterCubit) args,
  })  : displayContactInfo = args.$1,
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
        create: (context) => ContactViewCubit(
            launchCall: sl(),
            bloodGroup:
                widget.displayContactInfo.bloodGroup ?? BloodGroup.Unknown,
            locationCoordinates: widget.displayContactInfo.locationCoordinates),
        child: Builder(
          builder: (context) {
            var localContactViewState = context.watch<ContactViewCubit>().state;
            var localContactListingState =
                context.watch<ContactListingCubit>().state;

            if (localContactListingState is ContactListingSuccess) {
              var name = widget.displayContactInfo.name;
              var phone = widget.displayContactInfo.phone;
              // var bloodGroup =
              //     widget.displayContactInfo.bloodGroup ?? BloodGroup.Unknown;
              // var distanceFromUser = widget.displayContactInfo.distanceFromUser;
              // var locationGeoHash = widget.displayContactInfo.locationGeohash;
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
                                  editedBloodGroup:
                                      localContactViewState.currentBloodGroup,
                                  editedLocationCoordinates:
                                      localContactViewState
                                          .currentLocationCoordinates,
                                );
                          } else if (localContactViewState is ContactViewEdit) {
                            context
                                .read<ContactListingCubit>()
                                .updateContactInfo(
                                  phoneNumber: phone,
                                  bloodGroup:
                                      localContactViewState.currentBloodGroup,
                                  locationCoordinates: localContactViewState
                                      .currentLocationCoordinates,
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
                                    userLocation: context
                                        .read<FilterCubit>()
                                        .state
                                        .userLocation,
                                  ),
                                  fromCache: false,
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
                                            editedBloodGroup: selected ??
                                                localContactViewState
                                                    .currentBloodGroup,
                                          );
                                    }
                                  }
                                : null,
                            // TODO: check if compatibility color changes when edited
                            child: BloodIcon(
                              isLargeIcon: true,
                              bloodGroup:
                                  localContactViewState.currentBloodGroup,
                              bloodCompatibility:
                                  widget.displayContactInfo.bloodCompatibility,
                            ),
                          ),
                          LocationIcon(
                            isLargeIcon: true,
                            // TODO: what distance to show if its null
                            underneathText: widget
                                .displayContactInfo.distanceFromUser
                                .toString(),
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
