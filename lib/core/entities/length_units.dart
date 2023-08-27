import 'package:equatable/equatable.dart';

abstract class LengthUnit with EquatableMixin {
  final double value;
  String get unitSuffixInSI;
  double get lengthInMeters;
  const LengthUnit({required this.value});

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
}
