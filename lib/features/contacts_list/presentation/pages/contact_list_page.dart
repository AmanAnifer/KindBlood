import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing_cubit.dart';
import '../../injection_container.dart';
import 'package:kindblood/core/utils/blood_group_acronym.dart';
import '../widgets/listing.dart';

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
