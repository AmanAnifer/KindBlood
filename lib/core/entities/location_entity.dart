import 'package:json_annotation/json_annotation.dart';
part 'location_entity.g.dart';

@JsonSerializable()
class LatLong {
  final double latitude;
  final double longitude;
  LatLong({required this.latitude, required this.longitude});

  factory LatLong.fromJson(Map<dynamic, dynamic> json) =>
      _$LatLongFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$LatLongToJson(this);

  @override
  String toString() {
    return "$latitude °N, $longitude °E";
  }

  String toFixedSizedString({bool singleLine = false}) {
    return "${latitude.toStringAsFixed(4)} °N${singleLine ? ' ' : '\n'}${longitude.toStringAsFixed(4)} °E";
  }
}
