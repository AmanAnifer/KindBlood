import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kindblood/core/cubit/my_info_cubit.dart';
import '../../features/contacts_list/presentation/cubit/contact_listing/contact_listing_cubit.dart';
import '../../features/contacts_list/presentation/cubit/filter_widgets/filter_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../features/contacts_list/presentation/pages/pages_barrel.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/my_info/presentation/pages/myinfo_page.dart';
import 'package:flutter/material.dart';
import '../injection_container.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
part "bottom_navigation.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// class GoRouterRefreshStream extends ChangeNotifier {
//   GoRouterRefreshStream(Stream<dynamic> stream) {
//     notifyListeners();
//     subscription = stream.asBroadcastStream().listen((dynamic _) {
//       notifyListeners();
//     });
//   }

//   late final StreamSubscription<dynamic> subscription;

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
// }

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
    // refreshListenable: GoRouterRefreshStream(sl<MyInfoCubit>().stream),
    routes: [
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return child;
      //   },
      //   routes: [
      //     GoRoute(
      //       parentNavigatorKey: _shellNavigatorKey,
      //       path: listingScreen,
      //       builder: (context, state) => ContactListPage(),
      //       pageBuilder: (context, state) =>
      //           NoTransitionPage<void>(child: ContactListPage()),
      //       routes: [
      //         GoRoute(
      //           parentNavigatorKey: _shellNavigatorKey,
      //           path: contactViewScreen,
      //           builder: (context, state) {
      //             var args = state.extra as (
      //               DisplayContactInfo,
      //               ContactListingCubit,
      //               FilterCubit
      //             );
      //             return ContactViewPage(args: args);
      //           },
      //         ),
      //       ],
      //     ),
      //     GoRoute(
      //       parentNavigatorKey: _shellNavigatorKey,
      //       path: settingsScreen,
      //       builder: (context, state) => const SettingsPage(),
      //       pageBuilder: (context, state) =>
      //           const NoTransitionPage<void>(child: SettingsPage()),
      //     ),
      //     GoRoute(
      //       parentNavigatorKey: _shellNavigatorKey,
      //       path: myInfoScreen,
      //       builder: (context, state) => const MyInfoPage(),
      //       pageBuilder: (context, state) =>
      //           const NoTransitionPage(child: MyInfoPage()),
      //     ),
      //   ],
      // )

      StatefulShellRoute.indexedStack(
        // navigatorContainerBuilder: (context, navigationShell, children) =>
        //     _IndexedStackedRouteBranchContainer(
        //   currentIndex: navigationShell.currentIndex,
        //   children: children,
        // ),
        builder: (context, state, navigationShell) {
          return CustomScaffoldWithNavBar(navigationShell: navigationShell);
        },
        // builder: (context, children, navigationShell,) {
        //   return children;
        // },

        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: listingScreen,
                builder: (context, state) => const ContactListPage(),
                routes: [
                  GoRoute(
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
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: myInfoScreen,
                builder: (context, state) => const MyInfoPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: settingsScreen,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

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

// class _IndexedStackedRouteBranchContainer extends StatelessWidget {
//   const _IndexedStackedRouteBranchContainer(
//       {required this.currentIndex, required this.children});

//   final int currentIndex;

//   final List<Widget> children;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: children.mapWithIndex((widget, index) {
//         if (index == currentIndex) {
//           return widget;
//         } else {
//           return Visibility.maintain(
//             visible: false,
//             child: widget,
//           );
//         }
//       }).toList(),
//     );
//   }

//   Widget _buildRouteBranchContainer(
//       BuildContext context, bool isActive, Widget child) {
//     return Offstage(
//       offstage: !isActive,
//       child: TickerMode(
//         enabled: isActive,
//         child: child,
//       ),
//     );
//   }
// }
