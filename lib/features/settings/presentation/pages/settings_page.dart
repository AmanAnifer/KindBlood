import 'package:flutter/material.dart';
import 'package:kindblood/core/routing/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
