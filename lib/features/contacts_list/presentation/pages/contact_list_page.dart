import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/cubit/my_info_cubit.dart';
import '../cubit/contact_listing/contact_listing_cubit.dart';
import '../cubit/filter_widgets/filter_cubit.dart';
import '../../injection_container.dart';
import '../widgets/listing.dart';
import '../../../../core/routing/routes.dart' as routes;

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});
  // const ContactListPage() : super(key: key);
  @override
  State<ContactListPage> createState() => ContactListPageState();
}

class ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
    // myInfo =
    // final core_di.EitherMyInfoOrFailure eitherMyInfoOrFailure = sl();
    // eitherMyInfoOrFailure.fold(
    //   (l) => context.go(routes.Routes.myInfoScreen),
    //   (r) => myInfo = r,
    // );
  }

  void updateMyInfo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyInfoCubit, MyInfoState>(
      builder: (context, state) {
        // final localMyInfoState = state;
        if (state is MyInfoExists) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ContactListingCubit(
                  getContacts: sl(),
                  updateContact: sl(),
                  myInfo: state.myInfo,
                ),
              ),
              BlocProvider(
                create: (context) => FilterCubit(myInfo: state.myInfo),
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: const Text("KindBlood"),
                actions: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.refresh,
                        ),
                        onPressed: () {
                          context.read<ContactListingCubit>().populateContacts(
                                searchFilter: context
                                    .read<FilterCubit>()
                                    .state
                                    .searchFilter,
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
                    },
                  )
                ],
              ),
              body: const Listing(),
              // bottomNavigationBar: routes.CustomNavBar(),
            ),
          );
        } else {
          return const Center(child: Text("Please setup your info first"));
        }
      },
    );
  }
}
