import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/core/routing/routes.dart';
import '../cubit/myinfo_page_cubit.dart';
import '../../injection_container.dart';
import '../widgets/showing_info.dart';
import '../widgets/editing_info.dart';

final _formKey = GlobalKey<FormState>();

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late EditingInfoInputControllers editingInputControllers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyInfoPageCubit(myInfoUsecase: sl()),
      child: BlocBuilder<MyInfoPageCubit, MyInfoPageState>(
        builder: (context, state) {
          var localState = state;
          return Scaffold(
            appBar: (localState is MyInfoPageLoaded)
                ? AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.upload),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<MyInfoPageCubit>().startEditing();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  )
                : null,
            body: Center(child: () {
              if (localState is MyInfoPageFirstTime) {
                return const Text("Melcowe to KindBlood");
              } else if (localState is MyInfoPageLoading) {
                return const CircularProgressIndicator();
              } else if (localState is MyInfoPageLoaded) {
                return ShowingInfo(
                  myInfo: localState.myInfo,
                );
              } else if (localState is MyInfoPageEdit) {
                nameController = TextEditingController(
                    text: localState.previousMyInfo?.name);
                phoneController = TextEditingController(
                    text: localState.previousMyInfo?.phoneNumber);
                locationController = TextEditingController(
                    text: localState.previousMyInfo?.locationGeohash);
                editingInputControllers = EditingInfoInputControllers(
                  nameController: nameController,
                  phoneController: phoneController,
                  locationController: locationController,
                  bloodGroup: localState.previousMyInfo?.bloodGroup,
                );
                return EditingInfo(
                  formKey: _formKey,
                  isFirstTime: localState.isFirstEdit,
                  editingInputControllers: editingInputControllers,
                );
              }
            }()),
            floatingActionButton: () {
              if (localState is MyInfoPageFirstTime) {
                return FloatingActionButton.extended(
                  label: const Row(
                    children: [
                      Text("Proceed"),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                  onPressed: () {
                    context.read<MyInfoPageCubit>().startEditing();
                  },
                );
              } else if (localState is MyInfoPageEdit) {
                return FloatingActionButton(
                  child: const Icon(Icons.save),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Get actual location and blood group
                      context.read<MyInfoPageCubit>().updateMyInfo(
                            myInfo: MyInfo(
                              name: editingInputControllers.nameController.text,
                              phoneNumber:
                                  editingInputControllers.phoneController.text,
                              locationGeohash: editingInputControllers
                                  .locationController.text,
                              bloodGroup: editingInputControllers
                                  .bloodGroup!, // Wont reach here unless bloodGroup is validated not null so no problem
                            ),
                          );
                    }
                  },
                );
              }
            }(),
            bottomNavigationBar: (localState is MyInfoPageFirstTime ||
                    localState is MyInfoPageEdit)
                ? null
                : const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
