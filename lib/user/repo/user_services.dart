import 'dart:convert';
import 'dart:io';

import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/user/model/user.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

import '../../utils/resource_manager/error_manager.dart';

class UserSerevices {
  static Future<Object> login(UserModel userModel) async {
    final url = Uri.parse(UrlManager.login.url);
    try {
      // await updateRefreshToken();
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userModel.toJson()));
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return Success(response: res);
      }
      return ErrorManager.userInvalidResponse;
    } on HttpException {
      return ErrorManager.noInternetConnection;
    } on FormatException {
      return ErrorManager.invalidFormat;
    } catch (e) {
      return ErrorManager.unknown;
    }
  }

  static Future<Object> register(UserModel userModel) async {
    final url = Uri.parse(UrlManager.register.url);
    try {
      // await updateRefreshToken();
      if (userModel.password != userModel.rePassword) {
        return Failure(errResponse: "Password Not Match");
      }
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userModel.toJson()));
      if (response.statusCode == 201) {
        final res = jsonDecode(response.body)["refresh_token"];
        return Success(response: res);
      }
      return ErrorManager.userInvalidResponse;
    } on HttpException {
      return ErrorManager.noInternetConnection;
    } on FormatException {
      return ErrorManager.invalidFormat;
    } catch (e) {
      return ErrorManager.unknown;
    }
  }
}
