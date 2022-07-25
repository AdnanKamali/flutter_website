import 'dart:convert';

import 'package:shop_app/cart/repo/cart_services.dart';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

class CheckoutServices {
  static Future<Object> getCheckout() async {
    return "pass";
  }

  static Future<Object> postCheckout(CheckoutModel checkoutModel) async {
    checkoutModel.address = "Niavaran"; // test address
    checkoutModel.phoneNumber = 09175645235;
    final url = Uri.parse(UrlManager.Checkout.url);
    try {
      print("try");
      final repo = await http
          .post(url, body: jsonEncode(checkoutModel.toJson()), headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer ${CartServices.token}"
      });
      print(repo.body);
    } catch (e) {
      print("Error $e");
    }
    return Success();
  }

  static Future<Object> postOptCode(int code) async {
    final sampleCode = 2035;
    final url = Uri.parse(baseUrl + "/opt");
    try {
      print("try");
      final repo = await http
          .post(url, body: jsonEncode({"opt_code": sampleCode}), headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer ${CartServices.token}"
      });
      print(repo.body);
    } catch (e) {
      print("Error $e");
    }
    return Success();
  }
}
