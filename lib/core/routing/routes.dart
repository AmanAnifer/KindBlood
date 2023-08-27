import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/filter_widgets/filter_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:kindblood/features/contacts_list/presentation/pages/pages_barrel.dart';
import 'package:kindblood/features/settings/presentation/pages/settings_page.dart';
import 'package:kindblood/features/my_info/presentation/pages/myinfo_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../cubit/my_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part "bottom_navigation.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// For refreshListenable in GoRouter, but can't get it to work correctly so..
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class Routes {
  static const String listingScreen = "/";
  static const String settingsScreen = "/settings";
  static const String myInfoScreen = "/myInfo";
  // static const String contactViewScreen = "/listing/contact";
  static const String contactViewScreen = "contact";
  // final Stream<dynamic> cubitStream;
  // Routes({required this.cubitStream});
  static final GoRouter _router = GoRouter(
    initialLocation: myInfoScreen,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return child;
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: listingScreen,
            builder: (context, state) => const ContactListPage(),
            pageBuilder: (context, state) =>
                const NoTransitionPage<void>(child: ContactListPage()),
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: contactViewScreen,
                builder: (context, state) {
                  var args = state.extra as (
                    DisplayContactInfo,
                    ContactListingCubit,
                    FilterCubit
                  );
                  return ContactViewPage(args: args);
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: settingsScreen,
            builder: (context, state) => const SettingsPage(),
            pageBuilder: (context, state) =>
                const NoTransitionPage<void>(child: SettingsPage()),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: myInfoScreen,
            builder: (context, state) => const MyInfoPage(),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MyInfoPage()),
          ),
        ],
      )

      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     return navigationShell;
      //   },
      //   // navigatorContainerBuilder: (context, navigationShell, children)  {
      //   //   return child;
      //   // },
      //   branches: [
      //     StatefulShellBranch(
      //       navigatorKey: GlobalKey<NavigatorState>(),
      //       routes: [
      //         GoRoute(
      //           path: listingScreen,
      //           builder: (context, state) => const ContactListPage(),
      //           routes: [
      //             GoRoute(
      //               path: contactViewScreen,
      //               builder: (context, state) {
      //                 var args = state.extra as (
      //                   DisplayContactInfo,
      //                   ContactListingCubit,
      //                   FilterCubit
      //                 );
      //                 return ContactViewPage(args: args);
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: GlobalKey<NavigatorState>(),
      //       routes: [
      //         GoRoute(
      //           path: settingsScreen,
      //           builder: (context, state) => const SettingsPage(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       navigatorKey: GlobalKey<NavigatorState>(),
      //       routes: [
      //         GoRoute(
      //           path: myInfoScreen,
      //           builder: (context, state) => const MyInfoPage(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

      // GoRoute(
      //   path: permissionsScreen,
      //   builder: (context, state) => const PermissionsScreen(),
      // ),
      // GoRoute(
      //   path: homeScreen,
      //   builder: (context, state) => HomeScreen(),
      // ),
      // GoRoute(
      //   path: mapScreen,
      //   builder: (context, state) => MapScreen(
      //     stuff: state.extra as Map,
      //   ),
      // ),
      // GoRoute(
      //   path: altLocationScreen,
      //   builder: (context, state) => const AlternateLocationScreen(),
      // ),
      // GoRoute(
      //   path: aboutScreen,
      //   builder: (context, state) => const AboutScreen(),
      // ),
    ],
  );

  static GoRouter get router => _router;
}
