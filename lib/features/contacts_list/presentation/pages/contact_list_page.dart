import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing_cubit.dart';
import '../../injection_container.dart';
import 'package:kindblood/core/utils/blood_group_acronym.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContactListingCubit>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: () {
                  context.read<ContactListingCubit>().populateContacts();
                },
              );
            })
          ],
        ),
        body: const Listing(),
      ),
    );
  }
}

class Listing extends StatelessWidget {
  const Listing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: BlocBuilder<ContactListingCubit, ContactListingState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ContactListingLoading:
            return const CircularProgressIndicator();
          case ContactListingSuccess:
            return ListView.builder(
              // cacheExtent: 40,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.contactsList[index].name ?? "Unknown"),
                  subtitle: Text(state.contactsList[index].phone),
                  trailing:
                      // Text(state.contactsList[index].bloodGroup.toString()),
                      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 30,
                        Icons.water_drop,
                        // color: Colors.redAccent.shade700,
                        color: Colors.yellow.shade700,
                      ),
                      Text(
                        // getBloodGroupAcronym(
                        //   state.contactsList[index].bloodGroup,
                        // ),
                        "AB +ve",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  leading:
                      Text(state.contactsList[index].locationGeohash ?? "? km"),
                );
              },
              itemCount: (state as ContactListingSuccess).contactsList.length,
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
    ));
  }
}
