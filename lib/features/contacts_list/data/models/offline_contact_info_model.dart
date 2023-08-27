import 'package:kindblood_common/core_entities.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offline_contact_info_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class OfflineContactInfoModel extends OfflineContactInfo {
  const OfflineContactInfoModel({
    required super.id,
    super.name,
    super.phone,
    super.bloodGroup,
    super.locationCoordinates,
  });

  factory OfflineContactInfoModel.fromContactInfo(
          {required ContactInfo contactInfo}) =>
      OfflineContactInfoModel(
        id: contactInfo.id,
        name: contactInfo.name,
        phone: contactInfo.phone,
        bloodGroup: contactInfo.bloodGroup,
        locationCoordinates: contactInfo.locationCoordinates,
      );

  factory OfflineContactInfoModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineContactInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineContactInfoModelToJson(this);
}
