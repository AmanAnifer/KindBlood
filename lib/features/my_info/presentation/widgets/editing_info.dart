import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindblood/core/entities/blood_group.dart';
import 'package:kindblood/core/utils/blood_group_acronym.dart';
import '../../../../core/widgets/location_selection_page.dart';
import '../../../../core/entities/location_entity.dart' as le;

class EditingInfoInputControllers {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController locationController;
  BloodGroup? bloodGroup;
  le.LatLong? latLong;
  EditingInfoInputControllers({
    required this.nameController,
    required this.phoneController,
    required this.locationController,
    this.bloodGroup,
    this.latLong,
  });
}

class EditingInfo extends StatefulWidget {
  final bool isFirstTime;
  final GlobalKey<FormState> formKey;
  final EditingInfoInputControllers editingInputControllers;
  const EditingInfo({
    super.key,
    required this.formKey,
    required this.isFirstTime,
    required this.editingInputControllers,
  });

  @override
  State<StatefulWidget> createState() => _EditingInfoState();
}

class _EditingInfoState extends State<EditingInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.editingInputControllers.nameController.dispose();
    widget.editingInputControllers.phoneController.dispose();
    widget.editingInputControllers.locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: it doesnt look like contacts page updates when myInfo is updated
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            widget.isFirstTime ? "Set your details" : "Edit your details",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(
            flex: 1,
          ),
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (newValue) {},
                  controller: widget.editingInputControllers.nameController,
                  // initialValue: widget.previousMyInfo?.name,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: widget.editingInputControllers.phoneController,
                  // initialValue: widget.previousMyInfo?.phoneNumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    label: Text("Phone Number"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return "Please enter your 10 digit phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  value: widget.editingInputControllers.bloodGroup,
                  decoration: const InputDecoration(
                    label: Text("Blood group"),
                    border: OutlineInputBorder(),
                  ),
                  items: (BloodGroup.values.toList()
                        ..remove(BloodGroup
                            .Unknown)) // Don't allow unknown blood groups
                      .map<DropdownMenuItem<BloodGroup>>(
                        (group) => DropdownMenuItem(
                          value: group,
                          child: Text(
                            getBloodGroupAcronym(group) ?? "?",
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    widget.editingInputControllers.bloodGroup = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select your blood group";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:
                            widget.editingInputControllers.locationController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Getting your location...",
                          suffixIcon: IconButton(
                            onPressed: () {
                              showGeneralDialog(
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Material(
                                    child: LocationSelection(
                                      startPosition: widget
                                          .editingInputControllers.latLong,
                                      callback: (latLong) {
                                        widget
                                            .editingInputControllers
                                            .locationController
                                            .text = latLong.toString();
                                        widget.editingInputControllers.latLong =
                                            latLong;
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add_location),
                          ),
                          label: const Text("Location coordinates"),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          // if (kDebugMode || kProfileMode) {
                          //   return null;
                          // } else if (value == null || value.isEmpty) {
                          //   return "Location is required";
                          // }
                          if (widget.editingInputControllers.latLong == null) {
                            return "Location is required";
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
