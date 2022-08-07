import 'dart:convert';

import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

class TokenServices {
  static Future<Object> postRefreshToken(String refresh_token) async {
    final url = Uri.parse(UrlManager.refresh.url);
    try {
      final response = await http
          .post(url, headers: {"Authorization": "Bearer $refresh_token"});
      if (response.statusCode == 200) {
        final tokenModel = jsonDecode(response.body)["access_token"];
        return Success(response: tokenModel);
      }
      return Failure(errResponse: "Not Validate Refresh Token");
    } catch (e) {
      return Failure(errResponse: "Unknown Error");
    }
  }
}
