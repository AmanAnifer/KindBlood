import 'package:json_annotation/json_annotation.dart';
import 'package:kindblood_common/core_entities.dart';
part 'myinfo_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class MyInfoModel extends MyInfo {
  const MyInfoModel({
    required super.name,
    required super.phoneNumber,
    required super.bloodGroup,
    required super.locationCoordinates,
    super.lastDonateDate,
  });

  factory MyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MyInfoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyInfoModelToJson(this);

  factory MyInfoModel.fromMyInfo({required MyInfo myInfo}) {
    return MyInfoModel(
      name: myInfo.name,
      phoneNumber: myInfo.phoneNumber,
      bloodGroup: myInfo.bloodGroup,
      locationCoordinates: myInfo.locationCoordinates,
      lastDonateDate: myInfo.lastDonateDate,
    );
  }
}
