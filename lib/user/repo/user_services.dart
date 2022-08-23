import 'dart:convert';
import 'dart:io';

import 'package:shop_app/product/repo/api_status.dart';
// import 'package:shop_app/user/model/user.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

import '../../utils/resource_manager/error_manager.dart';

// final response = await http.post(url,
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(userModel.toJson()));

class UserSerevices {
  static Future<Object> postFullName(
      String fName, String lName, String accessToken) async {
    final url = Uri.parse(UrlManager.fullName.url);
    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    try {
      final repo = await http.post(url,
          headers: header,
          body: json.encode({"first_name": fName, "last_name": lName}));
      if (repo.statusCode == 200) {
        return Success(response: jsonDecode(repo.body));
      } else {
        return Failure();
      }
    } on HttpException {
      return ErrorManager.noInternetConnection;
    } on FormatException {
      return ErrorManager.invalidFormat;
    } catch (e) {
      return ErrorManager.unknown;
    }
  }

  static Future<Object> postPhoneNumber(String phoneNumber) async {
    final url = Uri.parse(UrlManager.phoneNumber.url);
    try {
      final repo = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"phone_number": phoneNumber}));
      if (repo.statusCode == 200) {
        // go to login page
        return Success(code: 200, response: jsonDecode(repo.body));
      } else {
        return Failure();
      }
    } on HttpException {
      return ErrorManager.noInternetConnection;
    } on FormatException {
      return ErrorManager.invalidFormat;
    } catch (e) {
      return ErrorManager.unknown;
    }
  }

  static Future<Object> postOtpCode(String code, String token) async {
    final url = Uri.parse(UrlManager.otpCheck.url);
    try {
      final repo = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({"opt_code": code}));
      if (repo.statusCode < 205) {
        return Success(response: jsonDecode(repo.body), code: repo.statusCode);
      } else {
        return Failure();
      }
    } on HttpException {
      return ErrorManager.noInternetConnection;
    } on FormatException {
      return ErrorManager.invalidFormat;
    } catch (e) {
      return ErrorManager.unknown;
    }
  }
}
