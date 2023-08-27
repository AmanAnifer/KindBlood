import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  final double? distanceInKm;
  final bool isLargeIcon;
  const LocationIcon({
    super.key,
    this.distanceInKm,
    this.isLargeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.pin_drop,
          size: isLargeIcon ? 60 : 0,
        ),
        Text(
          "${distanceInKm ?? '?'}${isLargeIcon ? ' ' : '\n'}km",
          textAlign: TextAlign.center,
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
