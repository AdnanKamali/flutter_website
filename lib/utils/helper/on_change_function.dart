import '../../viewModel/error_handler_view_model.dart';

void onPhoneNumberChanged(
    String? phoneNumber, ErrorHandlerViewModel errorHandlerViewModel) {
  if (phoneNumber!.length == 11) {
    errorHandlerViewModel.removeLengthError();
  } else if (phoneNumber.length != 11 && !errorHandlerViewModel.lengthError) {
    errorHandlerViewModel.addLengthError();
  }
  final checkInt = int.tryParse(phoneNumber);
  if (!phoneNumber.startsWith("09")) {
    errorHandlerViewModel.addErrorPhoneNumber();
    return;
  } else {
    errorHandlerViewModel.removeErrorPhoneNumber();
  }
  if (phoneNumber.length > 11 || checkInt == null) {
    errorHandlerViewModel.changeTextOfError("شماره اشتباه وارد شده");
    errorHandlerViewModel.addErrorPhoneNumber();
    return;
  } else {
    errorHandlerViewModel.changeTextOfError(null);
    errorHandlerViewModel.removeErrorPhoneNumber();
  }
}

void onOtpCodeChagne(
    String otpCode, ErrorHandlerViewModel errorHandlerViewModel) {
  if (errorHandlerViewModel.otpCodeError != null)
    errorHandlerViewModel.removeOtpError();
  final bool is5 = otpCode.length == 5;
  final tryInt = int.tryParse(otpCode);
  if (is5 && tryInt != null) {
    errorHandlerViewModel.enableConfirmButton(true);
    return;
  }
  if (!is5 && errorHandlerViewModel.isEnableButton) {
    errorHandlerViewModel.enableConfirmButton(false);
  }
}
