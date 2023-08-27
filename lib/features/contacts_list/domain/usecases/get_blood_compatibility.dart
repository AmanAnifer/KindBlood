import '../entities/blood_group.dart';
import '../entities/blood_compatibility_info.dart';

BloodCompatibility getBloodCompatibility({
  required BloodGroup receiver,
  required BloodGroup donor,
}) {
  return BloodCompatibility.incompatible;
}
