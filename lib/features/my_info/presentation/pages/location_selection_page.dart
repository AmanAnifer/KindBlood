import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../../../core/entities/location_entity.dart' as le;

class LocationSelection extends StatelessWidget {
  final void Function(le.LatLong latLong) callback;
  const LocationSelection({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterLocationPicker(
      showContributorBadgeForOSM: true,
      onPicked: (pickedData) {
        // TODO: Permission ask
        callback(le.LatLong(
          latitude: pickedData.latLong.latitude,
          longitude: pickedData.latLong.longitude,
        ));
        Navigator.pop(context);
      },
    );
  }
}
