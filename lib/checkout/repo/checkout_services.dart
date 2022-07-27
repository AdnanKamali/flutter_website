import 'dart:convert';

import 'package:shop_app/cart/repo/cart_services.dart';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

class CheckoutServices {
  static Future<Object> getCheckout() async {
    final url = Uri.parse(UrlManager.Checkout.url);
    try {
      final repo = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer ${CartServices.token}"
      });
      if (repo.statusCode == 200) {
        final checkoutListmodel = checkoutListModelFromJson(repo.body);
        return Success(response: checkoutListmodel);
      }
      return Failure(errResponse: "Not Validate");
    } catch (e) {
      // error handle
      return Failure(errResponse: "Catched");
    }
  }

  static Future<Object> postCheckout(CheckoutModel checkoutModel) async {
    // please handle errors
    final url = Uri.parse(UrlManager.Checkout.url);
    try {
      final repo = await http
          .post(url, body: jsonEncode(checkoutModel.toJson()), headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer ${CartServices.token}"
      });
      if (repo.statusCode == 200) {
        return Success();
      }
      return Failure();
    } catch (e) {
      return Failure();
    }
  }

  static Future<Object> postOptCode(int code) async {
    // handle errors
    final sampleCode = 2035;
    final url = Uri.parse(baseUrl + "/opt");
    try {
      final repo = await http
          .post(url, body: jsonEncode({"opt_code": sampleCode}), headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer ${CartServices.token}"
      });
      if (repo.statusCode == 200) {
        return Success();
      }
      return Failure();
    } catch (e) {
      return Failure();
    }
  }
}
