import '../../domain/entities/myinfo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kindblood/core/entities/blood_group.dart';

part 'myinfo_model.g.dart';

@JsonSerializable()
class MyInfoModel extends MyInfo {
  MyInfoModel({
    required super.name,
    required super.phoneNumber,
    required super.bloodGroup,
    required super.locationGeohash,
    super.lastDonateDate,
  });

  factory MyInfoModel.fromJson({required Map<String, dynamic> json}) =>
      _$MyInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyInfoModelToJson(this);

  factory MyInfoModel.fromMyInfo({required MyInfo myInfo}) {
    return MyInfoModel(
      name: myInfo.name,
      phoneNumber: myInfo.phoneNumber,
      bloodGroup: myInfo.bloodGroup,
      locationGeohash: myInfo.locationGeohash,
    );
  }
}
