import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/sort_widgets/sort_cubit.dart';
import 'package:kindblood_common/core_entities.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import '../cubit/contact_view/contact_view_cubit.dart';
import '../cubit/filter_widgets/filter_cubit.dart';
import '../../injection_container.dart';
import '../../../../core/widgets/blood_icon.dart';
import '../../../../core/widgets/select_blood_group.dart' as blood_select;
import '../../../../core/widgets/location_icon.dart';
import '../../../../core/utils/optimal_viewing_lengthunit.dart';
import '../../../../core/widgets/location_selection_page.dart';

class ContactViewPage extends StatefulWidget {
  final DisplayContactInfo displayContactInfo;
  final ContactListingCubit _contactListingCubit;
  final FilterCubit _filterCubit;
  final SortCubit _sortCubit;
  ContactViewPage({
    super.key,
    required (
      DisplayContactInfo,
      ContactListingCubit,
      FilterCubit,
      SortCubit
    ) args,
  })  : displayContactInfo = args.$1,
        _contactListingCubit = args.$2,
        _filterCubit = args.$3,
        _sortCubit = args.$4;

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
        BlocProvider.value(value: widget._sortCubit),
        BlocProvider(
          create: (context) => ContactViewCubit(
              launchCall: sl(),
              bloodGroup:
                  widget.displayContactInfo.bloodGroup ?? BloodGroup.Unknown,
              locationCoordinates:
                  widget.displayContactInfo.locationCoordinates),
        ),
      ],
      child: Builder(
        builder: (context) {
          var localContactViewState = context.watch<ContactViewCubit>().state;
          var localContactListingState =
              context.watch<ContactListingCubit>().state;

          if (localContactListingState is ContactListingSuccess) {
            var contactId = widget.displayContactInfo.id;
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
                                editedLocationCoordinates: localContactViewState
                                    .currentLocationCoordinates,
                              );
                        } else if (localContactViewState is ContactViewEdit) {
                          context.read<ContactListingCubit>().updateContactInfo(
                                id: contactId,
                                bloodGroup:
                                    localContactViewState.currentBloodGroup,
                                locationCoordinates: localContactViewState
                                    .currentLocationCoordinates,
                              );
                          context.read<ContactViewCubit>().endEdit();
                          context.read<ContactListingCubit>().populateContacts(
                                searchFilter: context
                                    .read<FilterCubit>()
                                    .state
                                    .searchFilter,
                                sortBy: context.read<SortCubit>().state.sortBy,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: BloodIcon(
                            isLargeIcon: true,
                            bloodGroup: localContactViewState.currentBloodGroup,
                            bloodCompatibility:
                                widget.displayContactInfo.bloodCompatibility,
                          ),
                          onPressed: localContactViewState is ContactViewEdit
                              ? () async {
                                  var selected = await blood_select
                                      .bloodTypeSelectDialogBuilder(context);
                                  if (mounted) {
                                    context.read<ContactViewCubit>().editDetail(
                                          editedBloodGroup: selected ??
                                              localContactViewState
                                                  .currentBloodGroup,
                                        );
                                  }
                                }
                              : null,
                        ),
                        IconButton(
                          onPressed: localContactViewState is ContactViewEdit
                              ? () async {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (dialogContext, animation,
                                        secondaryAnimation) {
                                      return Material(
                                        child: LocationSelection(
                                          startPosition: localContactViewState
                                              .currentLocationCoordinates,
                                          callback: (latLong) async {
                                            if (mounted) {
                                              context
                                                  .read<ContactViewCubit>()
                                                  .editDetail(
                                                    editedLocationCoordinates:
                                                        latLong,
                                                  );
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                              : null,
                          icon: LocationIcon(
                            isLargeIcon: true,
                            underneathText: localContactViewState
                                    .currentLocationCoordinates
                                    ?.toFixedSizedString() ??
                                "Unknown",
                            // callback:
                            //     localContactViewState is ContactViewEdit
                            //         ? () {}
                            //         : null,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                    Hero(
                      tag: contactId,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          name ?? "",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    Text(
                      // TODO: unknown number
                      phone ?? "",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      widget.displayContactInfo.distanceFromUser == null
                          ? "Unknown distance from here"
                          : "About ${getOptimalViewingLengthUnit(distance: widget.displayContactInfo.distanceFromUser!)} from here",
                      style: Theme.of(context).textTheme.headlineSmall,
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
                          if (phone != null) {
                            context.read<ContactViewCubit>().callNumber(phone);
                          }
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
    );
  }
}
