import 'package:flutter/material.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../viewModel/user_view_model.dart';

class SignForm extends StatelessWidget {
  SignForm({super.key, required this.userViewModel});
  final UserViewModel userViewModel;
  final _formKey = GlobalKey<FormState>();
  // add to view model

  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  // add to view model
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // buildUsernameFormField(userViewModel.setUserName, translate),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildPasswordFormField(userViewModel.setPassword, translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  translate("forgot password"),
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: translate("login"),
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                // final result = await userViewModel.login();
                var result = Failure();
                if (result is Failure) {
                  scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text(translate("Username Or Password Not Currect"),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(18))),
                    backgroundColor: Colors.redAccent,
                  ));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField(
      void Function(String?) save, String Function(String) translate) {
    return TextFormField(
      obscureText: true,
      onSaved: save,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: translate("error null passwrod"));
        } else if (value.length >= 6) {
          removeError(error: translate("error short password"));
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: translate("error null passwrod"));
          return "";
        } else if (value.length < 8) {
          addError(error: translate("error short password"));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate("password"),
        hintText: translate("enter your password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameFormField(
      void Function(String?) save, String Function(String) translate) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: save,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: translate("error null username"));
        } else if (usernameValidatorRegExp.hasMatch(value)) {
          removeError(error: translate("error not valid username"));
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: translate("error null username"));
          return "";
        } else if (!usernameValidatorRegExp.hasMatch(value)) {
          addError(error: translate("error not valid username"));
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: translate("username"),
        hintText: translate("enter your username"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
