import 'package:shop_app/viewModel/error_handler_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

void onPhoneNumberSaved(String? phoneNumber, UserViewModel userViewModel,
    ErrorHandlerViewModel errorHandlerViewModel) {
  if (phoneNumber?.length == 11)
    userViewModel.setPhoneNumber(phoneNumber);
  else {
    errorHandlerViewModel.changeTextOfError("شماره اشتباه وارد شده");
    errorHandlerViewModel.addErrorPhoneNumber();
  }
}

void onOtpCodeSaved(String? otpCode, UserViewModel userViewModel) {
  userViewModel.setOptCode(otpCode!);
}

void onFullNameSaved(String? fullName, void setFullName(String? lastName)) {
  if (fullName!.isEmpty) {
    return;
  }
  setFullName(fullName);
}
