import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/utils/resource_manager/timer.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../../viewModel/error_handler_view_model.dart';
import '../../viewModel/user_view_model.dart';

import '../helper/on_change_function.dart';
import '../helper/on_pressed_function.dart';
import '../helper/on_saved_function.dart';

final double buttonSize = 45;

final InputDecoration inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: BorderSide(color: Colors.grey)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: BorderSide(color: kPrimaryColor)),
);
final formFieldStyle = TextStyle(fontSize: getProportionateScreenWidth(14));

Future<dynamic> sign_up(BuildContext context, List<Widget> widgetPage,
    [double? size, Text? title]) {
  final isDesktop = Responsive.isDesktop(context);
  List<double> heightSizePages = [340, 438, 500];
  final List<Text> titles = [
    Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "ورود", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: " یا ", style: TextStyle(fontWeight: FontWeight.w400)),
          TextSpan(
              text: "عضویت", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      style: TextStyle(fontSize: getProportionateScreenWidth(17)),
    ),
    Text(
      "تایید شماره",
      style: TextStyle(fontSize: getProportionateScreenWidth(17)),
    ),
    Text(
      "مشخصات خود را وارد کنید",
      style: TextStyle(fontSize: getProportionateScreenWidth(17)),
    ),
  ];
  return showDialog(
      context: context,
      builder: (ctx) {
        return Consumer<UserViewModel>(builder: (context, _userViewModel, _) {
          return SimpleDialog(
            title: title ?? titles[_userViewModel.pageIndex],
            children: [
              SizedBox(
                width: getProportionateScreenWidth(350),
                height: size ??
                    getProportionateScreenHeight(
                            heightSizePages[_userViewModel.pageIndex]) -
                        (isDesktop ? 0 : 80),
                child: widgetPage[_userViewModel.pageIndex],
              )
            ],
          );
        });
      });
}

Widget phoneNumberPageLogin(UserViewModel userViewModel,
    String Function(String word) translate, BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final timerSecond = Provider.of<TimerSecond>(context, listen: false);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
    child: Form(
      key: _formKey,
      child: Consumer<ErrorHandlerViewModel>(
          builder: (ctx, errorHandlerViewModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [Text(translate("phone number"))]),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: userViewModel.userModel.phoneNumber ?? "",
                textDirection: TextDirection.ltr,
                style: formFieldStyle,
                decoration: inputDecoration,
                keyboardType: TextInputType.number,
                onChanged: (phoneNumber) =>
                    onPhoneNumberChanged(phoneNumber, errorHandlerViewModel),
                onSaved: (phoneNumber) => onPhoneNumberSaved(
                    phoneNumber, userViewModel, errorHandlerViewModel)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  errorHandlerViewModel.textErrorPhoneNumber ??
                      translate("number starts with 09"),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(8),
                      color: errorHandlerViewModel.phoneNumberErrorColor),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            SizedBox(
              height: buttonSize,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => onPhoneNumberPressed(errorHandlerViewModel,
                    _formKey, userViewModel, timerSecond),
                child: Text(
                  translate("continue"),
                  textDirection: TextDirection.rtl,
                  // style: TextStyle(
                  //   fontSize: getProportionateScreenHeight(35),
                  // ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
              ),
            )
          ],
        );
      }),
    ),
  );
}

Widget confirmPhoneNumber(
    UserViewModel userViewModel, String Function(String word) translate) {
  String time = "01:30";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  return Padding(
    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
    child: Form(
      key: _formKey,
      child: Consumer<ErrorHandlerViewModel>(
          builder: (context, errorHandlerViewModel, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: translate("code") +
                        " " +
                        translate("confirm") +
                        " " +
                        translate("for") +
                        " "),
                TextSpan(
                    text: "${userViewModel.userModel.phoneNumber}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " " + translate("sent")),
              ]))
            ]),
            Row(children: [
              TextButton(
                  onPressed: () {
                    errorHandlerViewModel.removeOtpError();
                    errorHandlerViewModel.enableConfirmButton(false);
                    userViewModel.pageChanger(0);
                  },
                  child: Row(
                    children: [
                      Text(
                        translate("modified"),
                        style: TextStyle(color: Colors.green),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                      ),
                    ],
                  ))
            ]),
            SizedBox(height: getProportionateScreenHeight(15)),
            TextFormField(
              style: formFieldStyle,
              textDirection: TextDirection.ltr,
              decoration: inputDecoration.copyWith(
                  errorText: errorHandlerViewModel.otpCodeError,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red))),
              onChanged: (otpCode) =>
                  onOtpCodeChagne(otpCode, errorHandlerViewModel),
              // validator: (otpCode){},

              onSaved: (otpCode) => onOtpCodeSaved(otpCode, userViewModel),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TODO: create timer and after timer resend code button and start again timer
                Consumer<TimerSecond>(builder: (ctx, timerSecond, _) {
                  if (timerSecond.second! >= 60) {
                    final second = timerSecond.second! % 60;
                    if (second < 10) {
                      time = "01:0$second";
                    } else {
                      time = "01:$second";
                    }
                  } else {
                    final second = timerSecond.second! % 60;
                    if (second < 10) {
                      time = "00:0$second";
                    } else {
                      time = "00:$second";
                    }
                  }
                  return timerSecond.second == 0
                      ? TextButton(
                          onPressed: () async {
                            final repo = await userViewModel.postPhoneNumber();
                            if (repo is Success) {
                              timerSecond.startTimer();
                            }
                          },
                          child: Text("ارسال مجدد کد"))
                      : Text("$time شکیبا باشید");
                  // return Text("${timerSecond.second}");
                })
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)), // desktop is 80
            ElevatedButton(
              onPressed: errorHandlerViewModel.isEnableButton
                  ? () => onOtpCodePressed(
                      userViewModel, _formKey, errorHandlerViewModel)
                  : null,
              child: Text(
                translate(
                    "confirm"), // this is change if loged in change to vorood
                textDirection: TextDirection.rtl,
              ),
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  minimumSize: Size(double.infinity, buttonSize)),
            )
          ],
        );
      }),
    ),
  );
}

Widget signUpFullName(
    UserViewModel userViewModel, String Function(String word) translate) {
  final _formKey = GlobalKey<FormState>();
  return Padding(
    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [Text(translate("first name"))]),
          TextFormField(
            textDirection: TextDirection.rtl,
            style: formFieldStyle,
            decoration: inputDecoration,
            onSaved: (fristName) =>
                onFullNameSaved(fristName, userViewModel.setFirstName),
          ),
          Row(
            children: [
              Text(translate("last name")),
            ],
          ),
          TextFormField(
            textDirection: TextDirection.rtl,
            style: formFieldStyle,
            decoration: inputDecoration,
            onSaved: (lastName) =>
                onFullNameSaved(lastName, userViewModel.setLastName),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          ElevatedButton(
            onPressed: () => onFullNamePressed(userViewModel, _formKey),
            child: Text(
              translate("register"),
              textDirection: TextDirection.rtl,
            ),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: Size(double.infinity, buttonSize)),
          )
        ],
      ),
    ),
  );
}

Widget updateFullName(
    UserViewModel userViewModel, String Function(String word) translate) {
  final _formKey = GlobalKey<FormState>();
  return Padding(
    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [Text(translate("first name"))]),
          TextFormField(
            initialValue: userViewModel.userModel.firstName,
            textDirection: TextDirection.rtl,
            style: formFieldStyle,
            decoration: inputDecoration,
            onSaved: (fristName) =>
                onFullNameSaved(fristName, userViewModel.setFirstName),
          ),
          Row(
            children: [
              Text(translate("last name")),
            ],
          ),
          TextFormField(
            initialValue: userViewModel.userModel.lastName,
            textDirection: TextDirection.rtl,
            style: formFieldStyle,
            decoration: inputDecoration,
            onSaved: (lastName) =>
                onFullNameSaved(lastName, userViewModel.setLastName),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          ElevatedButton(
            onPressed: () => onFullNamePressed(userViewModel, _formKey),
            child: Text(
              translate("update"),
              textDirection: TextDirection.rtl,
            ),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: Size(double.infinity, buttonSize)),
          )
        ],
      ),
    ),
  );
}
