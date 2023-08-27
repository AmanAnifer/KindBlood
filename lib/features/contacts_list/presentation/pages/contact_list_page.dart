import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/core/injection_container.dart' as core_di;
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
    final core_di.EitherMyInfoOrFailure eitherMyInfoOrFailure = sl();
    eitherMyInfoOrFailure.fold(
      (l) => context.go(routes.Routes.myInfoScreen),
      (r) => myInfo = r,
    );
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
                        searchFilter:
                            context.read<FilterCubit>().state.searchFilter,
                        // SearchFilter(
                        //   contactSearchMode: ContactSearchMode.offline,
                        //   bloodGroup:
                        //       context.read<FilterCubit>().state.bloodGroup,
                        //   userLocation:
                        //       context.read<FilterCubit>().state.userLocation,

                        // ),
                        fromCache: false,
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
