String getNormalisedPhoneNumber({required String phoneNumber}) {
  String normalisedPhoneNumber = phoneNumber;
  // normalisedPhoneNumber = [" ", "(", ")", "-"].fold(
  //   normalisedPhoneNumber,
  //   (previousValue, element) {
  //     return previousValue.replaceAll(element, "");
  //   },
  // );
  for (var char in [" ", "(", ")", "-", "+91"]) {
    normalisedPhoneNumber = normalisedPhoneNumber.replaceAll(char, "");
  }
  return normalisedPhoneNumber;
}
