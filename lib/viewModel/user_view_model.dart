import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/user/model/user.dart';
import 'package:shop_app/user/repo/user_services.dart';
import 'package:shop_app/utils/user_error.dart';

class UserViewModel extends ChangeNotifier {
  UserError? _userError;
  UserError? get userError => _userError;
  void setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  UserModel _userModel = UserModel.base();
  UserModel get userModel => _userModel;
  void setUserName(String? username) {
    if (username != null) _userModel.username = username;
  }

  void setPassword(String? password) {
    if (password != null) _userModel.password = password;
  }

  void setRePassword(String? rePassword) {
    if (rePassword != null) _userModel.rePassword = rePassword;
  }

  void setUsernameLogedIn() async {
    final ins = await SharedPreferences.getInstance();
    _userModel.username = ins.getString("username");
  }

  void login(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final loginRepo = await UserSerevices.login(userModel);
    if (loginRepo is Success) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Login Success"),
      ));
      setRefreshToken(
          (loginRepo.response as Map<String, dynamic>)["refresh_token"]!);
      setUsernameInLocalStorage(
          (loginRepo.response as Map<String, dynamic>)["username"]!);
      html.window.location.reload();
      notifyListeners();
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Username Or Password Not Currect"),
        backgroundColor: Colors.redAccent,
      ));
      setUserError(UserError(message: loginRepo));
    }
  }

  Future<void> register(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final registerRepo = await UserSerevices.register(userModel);
    if (registerRepo is Failure) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Password not Match"),
        backgroundColor: Colors.redAccent,
      ));
    } else if (registerRepo is Success) {
      setRefreshToken(registerRepo.response as String);
      setUsernameInLocalStorage(_userModel.username!);
      html.window.location.reload();
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Accourding Error: this username alredy exists"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<SharedPreferences> get sharedPreferenceInstance async {
    return await SharedPreferences.getInstance();
  }

  void setRefreshToken(String refreshToken) async {
    final preference = await sharedPreferenceInstance;
    await preference.setString("refresh_token", refreshToken);
  }

  void setUsernameInLocalStorage(String username) async {
    final preference = await sharedPreferenceInstance;
    await preference.setString("username", username);
  }
}
