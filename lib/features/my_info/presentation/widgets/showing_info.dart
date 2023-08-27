import 'package:flutter/material.dart';
import 'package:kindblood/core/widgets/blood_icon.dart';
import 'package:kindblood/core/widgets/location_icon.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';
import 'package:kindblood/core/entities/blood_group.dart';

class ShowingInfo extends StatefulWidget {
  final MyInfo myInfo;
  const ShowingInfo({
    super.key,
    required this.myInfo,
  });

  @override
  State<ShowingInfo> createState() => _ShowingInfoState();
}

class _ShowingInfoState extends State<ShowingInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BloodIcon(
                isLargeIcon: true,
                bloodGroup: widget.myInfo.bloodGroup,
              ),
              LocationIcon(
                isLargeIcon: true,
                locationGeohash: widget.myInfo.locationGeohash,
              ),
            ],
          ),
          const Spacer(flex: 1),
          Text(
            widget.myInfo.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            widget.myInfo.phoneNumber,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
