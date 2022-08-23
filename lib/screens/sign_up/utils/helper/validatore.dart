import '../../../../constants.dart';

class Validator {
  static String? fullNameValidate(
      {String? fullName,
      required void addError(String error),
      required String translate(String en)}) {
    if (fullName!.isEmpty) {
      addError(translate("error null username"));

      return "";
    }

    return null;
  }

  static String? usernameValidate(
      {String? username,
      required void addError(String error),
      required String translate(String en)}) {
    if (username!.isEmpty) {
      addError(translate("error null username"));
      return "";
    } else if (!usernameValidatorRegExp.hasMatch(username)) {
      addError(translate("error not valid username"));
      return "";
    }

    return null;
  }

  static String? passwordValidate({
    String? password,
    required void addError(String error),
    required String translate(String en),
    required void setPassword(String password),
  }) {
    if (password!.isEmpty) {
      addError(translate("error null passwrod"));
      return "";
    } else if (password.length < 8) {
      addError(translate("error null passwrod"));
      return "";
    }
    setPassword(password);

    return null;
  }

  static String? rePasswordValidate({
    String? rePassword,
    required String password,
    required void addError(String error),
    required String translate(String en),
  }) {
    if (rePassword!.isEmpty) {
      addError(translate("error null passwrod"));
      return "";
    } else if ((password != rePassword)) {
      // addError( translate("error not match passwrod"));
      return "";
    }
    return null;
  }
}
