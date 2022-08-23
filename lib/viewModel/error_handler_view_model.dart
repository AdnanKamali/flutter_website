import 'package:flutter/material.dart';

class ErrorHandlerViewModel extends ChangeNotifier {
  void backToDefualt() {
    phoneNumberErrorColor = null;
    textErrorPhoneNumber = null;
    lengthError = false;
    isEnableButton = false;
  }

  Color? phoneNumberErrorColor = null;
  String? otpCodeError;
  String? textErrorPhoneNumber = null;
  bool lengthError = false;
  bool isEnableButton = false;

  void changeTextOfError(String? textError) {
    textErrorPhoneNumber = textError;
    notifyListeners();
  }

  void addErrorPhoneNumber() {
    if (phoneNumberErrorColor == null) {
      phoneNumberErrorColor = Colors.red;
      notifyListeners();
    }
  }

  void removeErrorPhoneNumber() {
    if (phoneNumberErrorColor != null) {
      phoneNumberErrorColor = null;
      notifyListeners();
    }
  }

  void setOtpError(String? error) {
    otpCodeError = error;
    notifyListeners();
  }

  void removeOtpError() {
    otpCodeError = null;
    notifyListeners();
  }

  void removeLengthError() {
    lengthError = false;
    notifyListeners();
  }

  void addLengthError() {
    lengthError = true;
    notifyListeners();
  }

  void enableConfirmButton(bool isEnable) {
    isEnableButton = isEnable;
    notifyListeners();
  }
}
