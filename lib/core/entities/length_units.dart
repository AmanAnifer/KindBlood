import 'package:equatable/equatable.dart';

sealed class LengthUnit with EquatableMixin {
  final double value;
  String get unitSuffixInSI;
  double get lengthInMeters;
  const LengthUnit({required this.value});

  factory LengthUnit.fromJson(Map<String, dynamic> json) {
    var lengthUnitType = json["LengthUnit"];
    switch (lengthUnitType) {
      case "Meter":
        return Meter(value: json["value"]);
      case "KiloMeter":
        return KiloMeter(value: json["value"]);
      case "InfiniteMeter":
      default:
        return const InfiniteMeter();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "LengthUnit": (this).runtimeType.toString(),
      "value": value,
    };
  }

  @override
  String toString() {
    return "${value.toInt()} $unitSuffixInSI";
  }

  @override
  List<Object?> get props => [lengthInMeters];
}

class Meter extends LengthUnit {
  @override
  String get unitSuffixInSI => "m";
  @override
  double get lengthInMeters => value;
  const Meter({required super.value});
}

class KiloMeter extends LengthUnit {
  @override
  String get unitSuffixInSI => "km";
  @override
  double get lengthInMeters => value * 1000;

  const KiloMeter({required super.value});
}

class InfiniteMeter extends LengthUnit {
  @override
  String get unitSuffixInSI => "";
  @override
  double get lengthInMeters => double.infinity;
  const InfiniteMeter() : super(value: double.infinity);

  @override
  String toString() {
    return "no limit";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "LengthUnit": (this).runtimeType.toString(),
    };
  }
}
