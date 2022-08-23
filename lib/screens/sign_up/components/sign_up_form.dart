import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/screens/sign_up/utils/helper/validatore.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/user_view_model.dart';
import 'dart:html' as html;

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  final UserViewModel userViewModel;

  const SignUpForm({super.key, required this.userViewModel});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    userViewModel = widget.userViewModel;
    // addError = widget.userViewModel.addError;
    // removeError = widget.userViewModel.removeError;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  late UserViewModel userViewModel;
  late List<String?> errors;
  late void Function(String) addError;
  late void Function(String) removeError;

  @override
  Widget build(BuildContext context) {
    // errors = userViewModel.errors;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final translate = DemoLocalizations.of(context).translate;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUsernameFormField(translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(translate),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: translate("register"),
            press: () async {
              // print();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // final result = await userViewModel.register();
                var result = Success();

                if (result is Success) {
                  html.window.location.reload();
                } else if (result is Failure) {
                  scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text("Password not Match"),
                    backgroundColor: Colors.redAccent,
                  ));
                } else {
                  scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text("Accourding  this username alredy exists"),
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

  TextFormField buildConformPassFormField(String translate(String key)) {
    return TextFormField(
      obscureText: true,
      // onSaved: (newValue) => userViewModel.setRePassword(newValue),
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(translate("error null passwrod"));
      //   } else if (value.isNotEmpty &&
      //       userViewModel.userModel.password == value) {
      //     removeError(translate("error not match password"));
      //   }
      // },
      // validator: (rePassword) => Validator.rePasswordValidate(
      //   rePassword: rePassword,
      //   password: userViewModel.userModel.password!,
      //   addError: addError,
      //   translate: translate,
      // ),
      decoration: InputDecoration(
        labelText: translate("re password"),
        hintText: translate("re enter your password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField(String translate(String key)) {
    return TextFormField(
      obscureText: true,
      // onSaved: (newValue) => userViewModel.setPassword(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(translate("error null passwrod"));
        } else if (value.length >= 8) {
          removeError(translate("error short password"));
        }
      },
      // validator: (password) => Validator.passwordValidate(
      //   password: password,
      //   addError: addError,
      //   translate: translate,
      //   setPassword: userViewModel.setPassword,
      // ),
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

  TextFormField buildUsernameFormField(String translate(String key)) {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => userViewModel.setUserName(newValue),
      onChanged: (value) {
        if (value.endsWith(" ")) {
          addError("not blank space");
        } else if (!value.contains(" ")) {
          removeError("not blank space");
        }
        if (value.isNotEmpty) {
          removeError(translate("error null username"));
        } else if (usernameValidatorRegExp.hasMatch(value)) {
          removeError(translate("error not valid username"));
        }
        return null;
      },
      validator: (username) => Validator.usernameValidate(
        username: username,
        addError: addError,
        translate: translate,
      ),
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

  TextFormField buildNameFormField(String translate(String key)) {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => userViewModel.setFullName(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(translate("error null username"));
        }
        return null;
      },
      validator: (fullName) => Validator.fullNameValidate(
        fullName: fullName,
        addError: addError,
        translate: translate,
      ),
      decoration: InputDecoration(
        labelText: translate("name"),
        hintText: translate("enter your name"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
