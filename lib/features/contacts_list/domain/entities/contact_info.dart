import '../../../../core/entities/blood_group.dart';
import '../../../../core/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ContactInfo extends Equatable {
  String get id;
  String? get name;
  String? get phone;
  LatLong? get locationCoordinates;
  BloodGroup? get bloodGroup;
  const ContactInfo();
  @override
  List<Object?> get props => [id, name, phone, locationCoordinates, bloodGroup];
}

class OfflineContactInfo extends ContactInfo {
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final LatLong? locationCoordinates;
  @override
  final BloodGroup? bloodGroup;
  const OfflineContactInfo({
    required this.id,
    this.name,
    this.phone,
    this.locationCoordinates,
    this.bloodGroup,
  });
}

class OnlineContactInfo extends ContactInfo {
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final LatLong? locationCoordinates;
  @override
  final BloodGroup? bloodGroup;
  final bool? isAnonVolunteer;
  const OnlineContactInfo(
      {required this.id,
      this.name,
      this.phone,
      this.locationCoordinates,
      this.bloodGroup,
      this.isAnonVolunteer});
}
