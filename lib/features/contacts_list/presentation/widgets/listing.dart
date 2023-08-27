import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sort_widgets/sort_cubit.dart';
import 'sort_widget.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import 'filter_widgets.dart';
import 'contacts_list_tile.dart';
import '../cubit/filter_widgets/filter_cubit.dart';

class Listing extends StatelessWidget {
  const Listing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiBlocListener(
        listeners: [
          BlocListener<FilterCubit, FilterState>(
            listener: (context, state) {
              context.read<ContactListingCubit>().populateContacts(
                    searchFilter: state.searchFilter,
                    sortBy: context.read<SortCubit>().state.sortBy,
                  );
            },
          ),
          BlocListener<SortCubit, SortState>(
            listener: (context, state) {
              context.read<ContactListingCubit>().populateContacts(
                    searchFilter:
                        context.read<FilterCubit>().state.searchFilter,
                    sortBy: state,
                  );
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FilterWidgets(),

              // ),
              const Divider(),
              const SortWidget(),
              const Divider(),
              Expanded(
                flex: 10,
                child: BlocBuilder<ContactListingCubit, ContactListingState>(
                  builder: (context, state) {
                    if (state is ContactListingLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ContactListingSuccess) {
                      return ListView.builder(
                        key: const PageStorageKey("contact_listing_key"),
                        // cacheExtent: 40,
                        itemBuilder: (context, index) {
                          return ContactListTile(
                            displayContactInfo: state.contactsList[index],
                          );
                        },
                        itemCount: state.contactsList.length,
                      );
                    } else if (state is ContactListingError) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is ContactListingInitial) {
                      context.read<ContactListingCubit>().populateContacts(
                            searchFilter:
                                context.read<FilterCubit>().state.searchFilter,
                            sortBy: context.read<SortCubit>().state.sortBy,
                          );
                      return const CircularProgressIndicator();
                    } else {
                      // print(state);
                      return const Center(child: Text("Unkown error"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
