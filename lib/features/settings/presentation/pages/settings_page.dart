import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kindblood/core/entities/app_settings.dart';
import '../cubit/settings_cubit.dart';
import 'package:kindblood/core/injection_container.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController serverAddressController;
  @override
  void initState() {
    super.initState();
    serverAddressController = TextEditingController();

    // TODO: set initial value in a cleaner fashion
    serverAddressController.text =
        sl<AppSettings>().onlineContactsEndpoint.toString();
  }

  @override
  void dispose() {
    serverAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(appSettings: sl()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Settings",
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            ListTile(
              title: const Text("Server address"),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return TextField(
                      onChanged: (value) {
                        context
                            .read<SettingsCubit>()
                            .updateServerAddress(url: value);
                      },
                      // onSubmitted: (value) {
                      //   print("done");
                      // },
                      controller: serverAddressController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
