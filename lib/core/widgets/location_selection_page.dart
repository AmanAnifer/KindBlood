import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:kindblood_common/core_entities.dart' as le;

class LocationSelection extends StatelessWidget {
  final void Function(le.LatLong latLong) callback;
  final le.LatLong? startPosition;
  const LocationSelection({
    super.key,
    required this.callback,
    this.startPosition,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterLocationPicker(
      // showSearchBar: false,
      initPosition: startPosition == null
          ? null
          : LatLong(startPosition!.latitude, startPosition!.longitude),
      showContributorBadgeForOSM: true,
      trackMyPosition: false,
      initZoom: 11,
      minZoomLevel: 1,
      maxZoomLevel: 20,
      onPicked: (pickedData) {
        callback(le.LatLong(
          latitude: pickedData.latLong.latitude,
          longitude: pickedData.latLong.longitude,
        ));
        Navigator.pop(
          context,
        );
      },
    );
  }
}
