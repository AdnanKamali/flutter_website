import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/user/model/user.dart';
import 'package:shop_app/user/repo/user_services.dart';
import 'package:shop_app/utils/user_error.dart';
import 'package:shop_app/viewModel/token_view_model.dart';
import 'package:shop_app/viewModel/widget_view_manager.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel() {
    getUsernameLogedIn();
  }

  WidgetManager? _widgetManager;
  WidgetManager? get widgetManager => _widgetManager;
  void setWidgetManager(WidgetManager widgetManager) {
    _widgetManager = widgetManager;
  }

  TokenViewModel? _tokenViewModel;
  TokenViewModel? get tokenViewModel => _tokenViewModel;
  void setTokenViewModel(TokenViewModel tokenViewModel) {
    _tokenViewModel = tokenViewModel;
    _tokenViewModel?.getAccessToken();
  }

  void backToDefualt() {
    _userModel = UserModel.base();
    _optCode = null;
  }

  UserError? _userError;
  UserError? get userError => _userError;
  void setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  String? _optCode;
  String? get optCode => _optCode;
  void setOptCode(String? code) {
    _optCode = code;
  }

  UserModel _userModel = UserModel.base();
  UserModel get userModel => _userModel;

  void setPhoneNumber(String? phoneNumber) {
    _userModel.phoneNumber = phoneNumber;
  }

  void setFirstName(String? firstName) {
    _userModel.firstName = firstName;
  }

  void setLastName(String? lastName) {
    _userModel.lastName = lastName;
  }

  Future<Object> postPhoneNumber() async {
    widgetManager?.clickCotinue(true);
    final repo = await UserSerevices.postPhoneNumber(userModel.phoneNumber!);
    widgetManager?.clickCotinue(false);
    if (repo is Success) {
      tokenViewModel?.setAccessToken((repo.response as Map)["access_token"]);

      return Success();
    } else {
      return Failure();
    }
  }

  Future<int> postOptCode() async {
    var accessToken = tokenViewModel?.accessToken;
    final repo = await UserSerevices.postOtpCode(_optCode!, accessToken!);
    if (repo is Success) {
      setPhoneNumberInLocalStorage();
      final refresh = (repo.response as Map)["refresh_token"];
      tokenViewModel?.saveRefreshTokenWithRegisterOrLogin(refresh);
      await tokenViewModel?.getAccessToken();
      final name = (repo.response as Map)["first_name"];
      if (name == "No Name") {
        return 201;
      }
      final firstName = (repo.response as Map)["first_name"];
      final lastName = (repo.response as Map)["last_name"];
      _userModel.firstName = firstName;
      _userModel.lastName = lastName;
      setFullNameInLocalStorage();
      return repo.code!;
    }
    return -1;
  }

  Future<Object> postFullName() async {
    final repo = await UserSerevices.postFullName(userModel.firstName!,
        userModel.lastName!, tokenViewModel!.accessToken!);
    if (repo is Success) {
      setFullNameInLocalStorage();
      return Success();
    }
    return Failure();
  }

  void getUsernameLogedIn() async {
    final ins = await SharedPreferences.getInstance();
    _userModel.firstName = ins.getString("firstName");
    _userModel.lastName = ins.getString("lastName");
    _userModel.phoneNumber = ins.getString("phoneNumber");
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  void pageChanger(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  void setFullNameInLocalStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("firstName", userModel.firstName!);
    sharedPreferences.setString("lastName", userModel.lastName!);
  }

  void setPhoneNumberInLocalStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("phoneNumber", userModel.phoneNumber!);
  }
}
