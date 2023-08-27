import 'package:json_annotation/json_annotation.dart';
import 'package:kindblood_common/core_entities.dart';

part 'online_contact_info_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class OnlineContactInfoModel extends OnlineContactInfo {
  const OnlineContactInfoModel({
    required super.id,
    super.name,
    super.phone,
    super.bloodGroup,
    super.locationCoordinates,
    super.isAnonVolunteer,
  });

  factory OnlineContactInfoModel.fromContactInfo(
          {required ContactInfo contactInfo}) =>
      OnlineContactInfoModel(
        id: contactInfo.id,
        name: contactInfo.name,
        phone: contactInfo.phone,
        bloodGroup: contactInfo.bloodGroup,
        locationCoordinates: contactInfo.locationCoordinates,
      );

  factory OnlineContactInfoModel.fromJson(Map<String, dynamic> json) =>
      _$OnlineContactInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineContactInfoModelToJson(this);
}
