// ignore_for_file: constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'blood_group.g.dart';

@JsonEnum(alwaysCreate: true)
enum BloodGroup {
  APositive,
  ANegative,
  ABPositive,
  ABNegative,
  BPositive,
  BNegative,
  OPositive,
  ONegative,
  Other,
  Unknown
}

BloodGroup bloodGroupfromJson(String json) {
  var reverseMap = Map.fromEntries(
    _$BloodGroupEnumMap.entries.map(
      (enumMapEntry) => MapEntry(enumMapEntry.value, enumMapEntry.key),
    ),
  );
  if (reverseMap.containsKey(json)) {
    return reverseMap[json]!;
  } else {
    throw StateError("BloodGroup key not in inverted Enum Map");
  }
}

String bloodGroupToJson(BloodGroup bloodGroup) {
  if (_$BloodGroupEnumMap.containsKey(bloodGroup)) {
    return _$BloodGroupEnumMap[bloodGroup]!;
  } else {
    throw StateError("BloodGroup not in Enum Map");
  }
}
