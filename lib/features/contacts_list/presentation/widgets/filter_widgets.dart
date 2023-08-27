import 'package:flutter/material.dart';
import 'package:conditional_parent_widget/conditional_parent_widget.dart';
import 'package:kindblood/features/contacts_list/domain/entities/search_filters.dart';
import '../cubit/filter_widgets/filter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/widgets/select_blood_group.dart' as blood_select;
import 'package:kindblood/core/widgets/select_distance_limit.dart'
    as distance_select;
import 'package:kindblood/core/widgets/location_selection_page.dart';
import 'package:kindblood/core/utils/blood_group_acronym.dart';

class FilterWidgets extends StatefulWidget {
  const FilterWidgets({
    super.key,
  });

  @override
  State<FilterWidgets> createState() => _FilterWidgetsState();
}

class _FilterWidgetsState extends State<FilterWidgets> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return ConditionalParentWidget(
          condition: true,
          parentBuilder: (child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                children: child,
              ),
            );
          },
          parentBuilderElse: (child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: addSpacingBetween(child),
              ),
            );
          },
          child: [
            // const TenWidthBox(),
            ActionChip(
              onPressed: () async {
                var selected =
                    await blood_select.bloodTypeSelectDialogBuilder(context);
                if (mounted) {
                  context.read<FilterCubit>().updateFilters(
                        newFilter:
                            state.searchFilter.copyWith(bloodGroup: selected),
                      );
                }
              },
              label: Text(
                  "Blood Type: ${getBloodGroupAcronym(state.bloodGroup) ?? 'All'}"),
            ),
            // const TenWidthBox(),
            ChoiceChip(
              onSelected: (isModeOnline) async {
                if (mounted) {
                  context.read<FilterCubit>().updateFilters(
                        newFilter: state.searchFilter.copyWith(
                          contactSearchMode: isModeOnline
                              ? ContactSearchMode.online
                              : ContactSearchMode.offline,
                        ),
                      );
                }
              },
              selected: state.contactSearchMode == ContactSearchMode.online,
              label: Text("Mode: ${state.contactSearchMode.name}"),
            ),
            // const TenWidthBox(),
            ...(state.contactSearchMode == ContactSearchMode.online
                ? <StatelessWidget>[
                    ChoiceChip(
                      onSelected: (showAnonVolunteers) async {
                        if (mounted) {
                          context.read<FilterCubit>().updateFilters(
                                newFilter: state.searchFilter.copyWith(
                                  showAnonVolunteers: showAnonVolunteers,
                                ),
                              );
                        }
                      },
                      selected: state.showAnonVolunteers ?? true,
                      label: const Text("Anonymous volunteers"),
                    )
                  ]
                : <StatelessWidget>[]),
            /*
            Can't use Visibility widget cuz addSpacing will add spacing even
            if widget isn't visible, thus showing 2 unit spaces
            */
            // const TenWidthBox(),
            ActionChip(
              onPressed: () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (dialogContext, animation, secondaryAnimation) {
                    return Material(
                      child: LocationSelection(
                        startPosition: state.userLocation,
                        callback: (latLong) async {
                          if (mounted) {
                            context.read<FilterCubit>().updateFilters(
                                  newFilter: state.searchFilter.copyWith(
                                    userLocation: latLong,
                                  ),
                                );
                          }
                        },
                      ),
                    );
                  },
                );
              },
              label: Text(
                  "Location: ${state.userLocation.toFixedSizedString(singleLine: true)}"),
            ),
            ActionChip(
              onPressed: () async {
                var selected =
                    await distance_select.showDistanceLimitSelectorDialog(
                  context,
                  state.maxDistance,
                );
                if (mounted && selected != null) {
                  context.read<FilterCubit>().updateFilters(
                        newFilter: state.searchFilter.copyWith(
                          maxDistance: selected,
                        ),
                      );
                }
              },
              label: Text(
                  "Within: ${state.maxDistance?.toString() ?? 'no limit'}"),
            ),
            // const TenWidthBox(),
            ChoiceChip(
              onSelected: (selected) {},
              selected: true,
              label: const Text("Can donate"),
            ),
          ],
        );
      },
    );
  }
}

List<Widget> addSpacingBetween(List<Widget> children) {
  /* 
  When showing the chips in SingleChildScrollView and Row, the Row's 
  mainAxisAlignment.spaceBetween doesn't work since it has no width constraints,
  so instead, add SizedBox between elements
  */
  List<Widget> spacedElements = [];
  for (var e in children) {
    spacedElements.add(e);
    spacedElements.add(
      const SizedBox(
        width: 10,
      ),
    );
  }
  spacedElements.removeLast();
  return spacedElements;
}
