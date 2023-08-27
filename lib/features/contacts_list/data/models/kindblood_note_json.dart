import '../../../../core/entities/blood_group.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'kindblood_note_json.g.dart';

// @JsonSerializable()
class KindBloodNoteData {
  final String? locationGeoHash;

  final BloodGroup? bloodGroup;
  KindBloodNoteData({this.locationGeoHash, this.bloodGroup});

  // factory KindBloodNoteData.fromJson(Map<String, dynamic> json) =>
  //     _$KindBloodNoteDataFromJson(json);

  // Map<String, dynamic> toJson() => _$KindBloodNoteDataToJson(this);
}
