import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/resource_manager/timer.dart';
import 'package:shop_app/viewModel/error_handler_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';
import 'dart:html' as html;

import '../../product/repo/api_status.dart';

void onPhoneNumberPressed(
    ErrorHandlerViewModel errorHandlerViewModel,
    GlobalKey<FormState> formKey,
    UserViewModel userViewModel,
    TimerSecond timerSecond) async {
  if (errorHandlerViewModel.lengthError) {
    errorHandlerViewModel.changeTextOfError("شماره وارد شده اشباه است");
    errorHandlerViewModel.addErrorPhoneNumber();
    return;
  }
  if (errorHandlerViewModel.phoneNumberErrorColor != null ||
      errorHandlerViewModel.textErrorPhoneNumber != null ||
      errorHandlerViewModel.lengthError) {
    return;
  }
  formKey.currentState?.save();
  if (userViewModel.userModel.phoneNumber == null) {
    return;
  }
  final repo = await userViewModel.postPhoneNumber();
  if (repo is Success) {
    userViewModel.pageChanger(1);
    timerSecond.startTimer();
  } else {
    // TODO: Error
  }
}

void onOtpCodePressed(UserViewModel userViewModel, GlobalKey<FormState> formKey,
    ErrorHandlerViewModel errorViewModel) async {
  formKey.currentState?.save();
  final a = await userViewModel.postOptCode();
  if (a == 200) {
    // loged in
    html.window.location.reload();
  } else if (a == 201) {
    // register go to get full name
    userViewModel.pageChanger(2);
  } else {
    // have error
    errorViewModel.setOtpError("کد امنیتی اشتباه است");
  }
}

void onFullNamePressed(
    UserViewModel userViewModel, GlobalKey<FormState> formKey) async {
  formKey.currentState?.save();
  if (userViewModel.userModel.firstName == null ||
      userViewModel.userModel.lastName == null) {
    return;
  }
  final repo = await userViewModel.postFullName();
  if (repo is Success) {
    html.window.location.reload();
  }
}
