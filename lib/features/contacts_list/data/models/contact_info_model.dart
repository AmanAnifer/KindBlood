import '../../domain/entities/contact_info.dart';
import 'package:kindblood/core/entities/location_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kindblood/core/entities/blood_group.dart';
part 'contact_info_model.g.dart';

@JsonSerializable()
class ContactInfoModel extends ContactInfo {
  ContactInfoModel({
    required super.name,
    required super.phone,
    super.bloodGroup,
    super.locationCoordinates,
  });

  factory ContactInfoModel.fromContactInfo(
          {required ContactInfo contactInfo}) =>
      ContactInfoModel(
        name: contactInfo.name,
        phone: contactInfo.phone,
        bloodGroup: contactInfo.bloodGroup,
        locationCoordinates: contactInfo.locationCoordinates,
      );

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactInfoModelToJson(this);
}
