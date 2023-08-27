import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  final double? distanceInKm;
  final String? locationGeohash;
  final bool isLargeIcon;
  const LocationIcon({
    super.key,
    this.distanceInKm,
    this.isLargeIcon = false,
    this.locationGeohash,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          size: isLargeIcon ? 60 : 0,
        ),
        Text(
          "${distanceInKm ?? locationGeohash ?? '?'}${isLargeIcon ? ' ' : '\n'}${(locationGeohash == null) ? 'km' : ''}",
          textAlign: TextAlign.center,
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
