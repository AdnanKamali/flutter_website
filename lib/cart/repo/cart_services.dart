import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/cart/model/Cart.dart';
import '../../product/repo/api_status.dart';
import '../../utils/resource_manager/error_manager.dart';
import '../../utils/resource_manager/url_manager.dart';

class CartServices {
  static Future<Object> getCart(String token) async {
    try {
      final url = Uri.parse(UrlManager.cart.url);
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final res = cartListModelFromJson(response.body);
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

  static Future<Object> postCart(Cart cart, String token) async {
    try {
      // updateRefreshToken();
      final url = Uri.parse(UrlManager.cart.url);
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(cart.toJson()));
      if (response.statusCode == 201) {
        return Success(response: response.body);
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

  static Future<Object> deleteCart(int id, String token) async {
    try {
      // updateRefreshToken();
      final url = Uri.parse(UrlManager.cart.url);
      final response = await http.delete(url,
          body: json.encode({"cart_id": id}),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body)["message"];
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
