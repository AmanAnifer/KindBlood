import 'package:flutter/material.dart';
import 'core/injection_container.dart' as core_di;
import 'features/contacts_list/injection_container.dart' as contacts_list_di;
import './core/routing/routes.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() async {
  // timeDilation = 3;
  await core_di.init();
  await contacts_list_di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: Routes.router.routeInformationProvider,
      routeInformationParser: Routes.router.routeInformationParser,
      routerDelegate: Routes.router.routerDelegate,
      title: "First Demo",
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.dark,
          ),
          useMaterial3: true),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      // home: const ContactListPage(),
    );
  }
}
