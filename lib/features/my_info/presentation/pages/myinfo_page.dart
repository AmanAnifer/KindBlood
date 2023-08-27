import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/routing/routes.dart';
import '../cubit/myinfo_page_cubit.dart';
import '../../injection_container.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyInfoPageCubit(myInfoUsecase: sl()),
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
