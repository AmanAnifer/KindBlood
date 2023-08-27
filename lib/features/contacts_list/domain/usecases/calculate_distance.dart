import 'dart:math' as math;
import '../../../../core/entities/length_units.dart';
import '../../../../core/entities/location_entity.dart';

// From stackoverflow
double _getDistanceFromLatLongInMeters(lat1, lon1, lat2, lon2) {
  var R = 6371000; // Radius of the earth in meters
  var dLat = _deg2rad(lat2 - lat1); // deg2rad below
  var dLon = _deg2rad(lon2 - lon1);
  var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_deg2rad(lat1)) *
          math.cos(_deg2rad(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  var d = R * c; // Distance in meters
  return d;
}

double _deg2rad(deg) {
  return deg * (math.pi / 180);
}

LengthUnit getDistanceBetweenTwoLatLongs(
    {required LatLong from, required LatLong to}) {
  var distance = _getDistanceFromLatLongInMeters(
    from.latitude,
    from.longitude,
    to.latitude,
    to.longitude,
  );
  return Meter(value: distance);
}
