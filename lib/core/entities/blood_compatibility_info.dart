sealed class BloodCompatibility {
  const BloodCompatibility();
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
