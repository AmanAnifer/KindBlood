import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/core/errors/failure.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import '../cubit/filter_widgets/filter_cubit.dart';
import '../../injection_container.dart';
import '../widgets/listing.dart';
import 'package:kindblood/core/routing/routes.dart' as routes;
import '../../domain/entities/search_filters.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late final MyInfo myInfo;

  @override
  void initState() {
    super.initState();
    final fpdart.Either<NoExistingMyInfoFailure, MyInfo> myInfoOrFailure = sl();
    myInfoOrFailure.fold(
      (l) => context.go(routes.Routes.myInfoScreen),
      (r) => myInfo = r,
    );
    // Cuz if myInfo isn't ready then it shouldn't show this screen
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactListingCubit(
              getContacts: sl(), updateContact: sl(), myInfo: myInfo),
        ),
        BlocProvider(
          create: (context) => FilterCubit(myInfo: myInfo),
        ),
      ],
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
                  context.read<ContactListingCubit>().populateContacts(
                        searchFilter: SearchFilter(
                            contactSearchMode: ContactSearchMode.offline,
                            bloodGroup:
                                context.read<FilterCubit>().state.bloodGroup),
                      );
                },
              );
            })
          ],
        ),
        body: const Listing(),
        bottomNavigationBar: const routes.CustomBottomNavigationBar(),
      ),
    );
  }
}
