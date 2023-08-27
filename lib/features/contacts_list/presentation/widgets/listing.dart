import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: BlocListener<FilterCubit, FilterState>(
      listener: (context, state) {
        context.read<ContactListingCubit>().populateContacts(
              searchFilter: state.searchFilter,
            );
      },
      child: BlocBuilder<ContactListingCubit, ContactListingState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ContactListingLoading:
              return const CircularProgressIndicator();
            case ContactListingSuccess:
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FilterWidgets(),

                  // ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                      key: const PageStorageKey("contact_listing_key"),
                      // cacheExtent: 40,
                      itemBuilder: (context, index) {
                        return ContactListTile(
                          displayContactInfo: state.contactsList[index],
                        );
                      },
                      itemCount:
                          (state as ContactListingSuccess).contactsList.length,
                    ),
                  ),
                ],
              );
            default:
              return Builder(
                builder: (context) {
                  context.read<ContactListingCubit>().populateContacts(
                        searchFilter:
                            context.read<FilterCubit>().state.searchFilter,
                      );
                  return const CircularProgressIndicator();
                  // return ElevatedButton(
                  //   onPressed: () {
                  //     context.read<ContactListingCubit>().populateContacts();
                  //   },
                  //   child: const Text(
                  //     "Read contacts",
                  //   ),
                  // );
                },
              );
          }
        },
      ),
    ));
  }
}
