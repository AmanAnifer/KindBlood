import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubit/my_info_cubit.dart';
import 'core/injection_container.dart' as core_di;
import 'core/routing/routes.dart';
import 'features/contacts_list/injection_container.dart' as contacts_list_di;
import 'features/my_info/injection_container.dart' as myinfo_di;

void main() async {
  // timeDilation = 3;
  await core_di.init();
  await myinfo_di.init();
  await contacts_list_di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyInfoCubit>(
      create: (context) => core_di.sl(),
      child: MaterialApp.router(
        // routeInformationProvider: Routes.router.routeInformationProvider,
        // routeInformationParser: Routes.router.routeInformationParser,
        // routerDelegate: Routes.router.routerDelegate,
        routerConfig: Routes.router,
        title: "KindBlood",
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            // brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        // home: const ContactListPage(),
      ),
    );
  }
}
