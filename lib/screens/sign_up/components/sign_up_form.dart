import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  final UserViewModel userViewModel;

  const SignUpForm({super.key, required this.userViewModel});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    userViewModel = widget.userViewModel;
    super.initState();
  }

  late UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(translate),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(translate),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: translate("continue"),
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                await userViewModel.register(context);

                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
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
      onSaved: (newValue) => userViewModel.setRePassword(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: translate("error null passwrod"));
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: translate("error not match password"));
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: translate("error null passwrod"));
          return "";
        } else if ((password != value)) {
          addError(error: translate("error not match passwrod"));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate("re password"),
        hintText: translate("re enter your password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField(String translate(String key)) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => userViewModel.setPassword(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: translate("error null passwrod"));
        } else if (value.length >= 8) {
          removeError(error: translate("error short password"));
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: translate("error null passwrod"));
          return "";
        } else if (value.length < 8) {
          addError(error: translate("error null passwrod"));
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameFormField(String translate(String key)) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => userViewModel.setUserName(newValue),
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
