abstract class LengthUnit {
  final double value;
  String get unitSuffixInSI;
  double get lengthInMeters;
  LengthUnit({required this.value});

  @override
  String toString() {
    return "${value.toInt()}$unitSuffixInSI";
  }
}

class Meter extends LengthUnit {
  @override
  String get unitSuffixInSI => "m";
  @override
  double get lengthInMeters => value;
  Meter({required super.value});
}

class KiloMeter extends LengthUnit {
  @override
  String get unitSuffixInSI => "km";
  @override
  double get lengthInMeters => value * 1000;

  KiloMeter({required super.value});
}

class InfiniteMeter extends LengthUnit {
  @override
  String get unitSuffixInSI => "";
  @override
  double get lengthInMeters => double.infinity;
  InfiniteMeter() : super(value: double.infinity);

  @override
  String toString() {
    return "no limit";
  }
}
