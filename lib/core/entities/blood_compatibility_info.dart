sealed class BloodCompatibility {
  const BloodCompatibility();
  Map<String, dynamic> toJson() {
    return {"BloodCompatibility": (this).runtimeType.toString()};
  }

  factory BloodCompatibility.fromJson(Map<String, dynamic> json) {
    var typeString = json["BloodCompatibility"];
    switch (typeString) {
      case "Compatible":
        return const Compatible();
      case "CompatibleSame":
        return const CompatibleSame();
      case "CompatibleButDifferent":
        return const CompatibleButDifferent();
      case "Incompatible":
      default:
        return const Incompatible();
    }
  }
}

class Compatible extends BloodCompatibility {
  const Compatible();
}

class CompatibleSame extends Compatible {
  const CompatibleSame();
}

class CompatibleButDifferent extends Compatible {
  const CompatibleButDifferent();
}

class Incompatible extends BloodCompatibility {
  const Incompatible();
}
