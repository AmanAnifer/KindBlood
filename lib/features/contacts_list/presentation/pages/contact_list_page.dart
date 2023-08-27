import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import '../../injection_container.dart';
import '../widgets/listing.dart';
import 'package:kindblood/core/routing/routes.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactListingCubit(getContacts: sl(), updateContact: sl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("KindBlood"),
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
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
