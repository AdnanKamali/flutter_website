import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/user/model/user.dart';
import 'package:shop_app/user/repo/user_services.dart';
import 'package:shop_app/utils/user_error.dart';
import 'package:shop_app/viewModel/token_view_model.dart';

class UserViewModel extends ChangeNotifier {
  final TokenViewModel? tokenViewModel;
  UserViewModel({this.tokenViewModel}) {
    if (tokenViewModel != null) {
      if (tokenViewModel?.accessToken != null)
        _accessToken = tokenViewModel?.accessToken;
      getUsernameLogedIn();
    }
  }

  String? _accessToken;
  String? get accessToken => _accessToken;

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

  void getUsernameLogedIn() async {
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

  void setRefreshToken(String refreshToken) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("refreshToken", refreshToken);
  }

  void setUsernameInLocalStorage(String username) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", username);
  }
}
