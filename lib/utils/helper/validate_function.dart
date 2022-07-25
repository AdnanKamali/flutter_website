class Validator {
  static String? phoneNumber(String? phoneNumber) {
    const String phoneNumberNotTrueError = "Phone Number Not True";
    if (phoneNumber != null) {
      final toInt = int.tryParse(phoneNumber);
      if (toInt == null)
        return phoneNumberNotTrueError;
      else if (toInt != 11) {
        return phoneNumberNotTrueError;
      }
      return null;
    } else {
      return "Enter Phone Number";
    }
  }

  static String? address(String? address) {
    if (address != null) {
      return null;
    }
    return "Enter Address";
  }
}
