import 'package:flutter/material.dart';
import 'package:kindblood/core/entities/length_units.dart';

class LocationIcon extends StatelessWidget {
  final LengthUnit? distance;
  final String? locationText;
  final bool isLargeIcon;
  const LocationIcon({
    super.key,
    this.distance,
    this.isLargeIcon = false,
    this.locationText,
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
          "${distance ?? locationText ?? '?'}${isLargeIcon ? ' ' : '\n'}${(locationText == null) ? 'km' : ''}",
          textAlign: TextAlign.center,
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
