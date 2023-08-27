import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  final String? underneathText;
  final bool isLargeIcon;
  const LocationIcon({
    super.key,
    this.isLargeIcon = false,
    this.underneathText,
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
          underneathText ?? '?',
          textAlign: TextAlign.center,
          style: isLargeIcon
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
