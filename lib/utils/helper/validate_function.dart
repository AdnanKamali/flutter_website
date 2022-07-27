class Validator {
  static String? phoneNumber(String? phoneNumber) {
    const String phoneNumberNotTrueError = "Phone Number Not True";
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final toInt = int.tryParse(phoneNumber);
      if (toInt == null)
        return phoneNumberNotTrueError;
      else if (phoneNumber.length != 11) {
        return phoneNumberNotTrueError;
      }
      return null;
    } else {
      return "Enter Phone Number";
    }
  }

  static String? address(String? address) {
    if (address != null && address.isNotEmpty) {
      if (address.length > 8)
        return null;
      else
        return "Address to short";
    }
    return "Enter Address";
  }
}
