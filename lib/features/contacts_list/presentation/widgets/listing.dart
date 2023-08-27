import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import './filter_widgets.dart';
import './contacts_list_tile.dart';

class Listing extends StatelessWidget {
  const Listing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      // cacheExtent: 40,
                      itemBuilder: (context, index) {
                        return ContactListTile(
                          index: index,
                          name: state.contactsList[index].name,
                          phone: state.contactsList[index].phone,
                          bloodGroup: state.contactsList[index].bloodGroup,
                          distanceInKm: state.contactsList[index].distanceInKm,
                        );
                      },
                      itemCount:
                          (state as ContactListingSuccess).contactsList.length,
                    ),
                  ),
                ],
              );
            default:
              return Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<ContactListingCubit>().populateContacts();
                  },
                  child: const Text(
                    "Read contacts",
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
