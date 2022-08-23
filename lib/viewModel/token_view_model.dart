import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/user/repo/token_services.dart';

import '../product/repo/api_status.dart';

class TokenViewModel extends ChangeNotifier {
  TokenViewModel() {
    autoLoginWithRefreshToken();
  }
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool isLogedIn = false;

  void autoLoginWithRefreshToken() async {
    setLoading(true);
    final sharedPreferences = await SharedPreferences.getInstance();
    final refreshToken = await sharedPreferences.getString("refreshToken");
    if (refreshToken != null) {
      final repo = await TokenServices.postRefreshToken(refreshToken);
      if (repo is Success) {
        _accessToken = repo.response as String;
        isLogedIn = true;
      }
    }
    setLoading(false);
  }

  void saveRefreshTokenWithRegisterOrLogin(String refreshToken) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("refreshToken", refreshToken);
  }

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<void> getAccessToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final refreshToken = sharedPreferences.getString("refreshToken");
    if (refreshToken != null) {
      final reciveAcessToken =
          await TokenServices.postRefreshToken(refreshToken);
      if (reciveAcessToken is Success) {
        _accessToken = reciveAcessToken.response as String;
      } else {
        return;
      }
    }
  }

  void setAccessToken(String token) {
    _accessToken = token;
  }
}
