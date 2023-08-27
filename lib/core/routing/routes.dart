import 'package:go_router/go_router.dart';
import 'package:kindblood/features/contacts_list/presentation/pages/pages_barrel.dart';

class Routes {
  static const String listingScreen = "/";
  static const String settingsScreen = "/settings";
  // static const String contactViewScreen = "/listing/contact";
  static const String contactViewScreen = "contact";
  static final GoRouter _router = GoRouter(
    initialLocation: listingScreen,
    routes: <GoRoute>[
      GoRoute(
        path: listingScreen,
        builder: (context, state) => const ContactListPage(),
        routes: [
          GoRoute(
            path: contactViewScreen,
            builder: (context, state) {
              var index = state.extra as int;
              return ContactViewPage(contactIndex: index);
            },
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
