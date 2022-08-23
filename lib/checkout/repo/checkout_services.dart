import 'dart:convert';
import 'package:shop_app/checkout/model/checkout.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';
import 'package:http/http.dart' as http;

class CheckoutServices {
  static Future<Object> getCheckout(String token) async {
    final url = Uri.parse(UrlManager.Checkout.url);
    try {
      final repo = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": " Bearer $token"
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

  static Future<Object> postCheckout(
      CheckoutModel checkoutModel, String token) async {
    // please handle errors
    final url = Uri.parse(UrlManager.Checkout.url);
    try {
      final repo = await http.post(url,
          body: jsonEncode(checkoutModel.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": " Bearer $token"
          });
      if (repo.statusCode == 200) {
        return Success(code: 200);
      } else if (repo.statusCode == 202) {
        const int codeNotExpired = 202;
        return Success(code: codeNotExpired);
      }
      return Failure();
    } catch (e) {
      return Failure();
    }
  }

  // static Future<Object> getCheckCodeAvalable(String token) async {
  //   // please handle errors
  //   final url = Uri.parse(baseUrl + "/opt_check");
  //   try {
  //     final repo = await http.get(url, headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": " Bearer $token"
  //     });
  //     const int codeNotExpired = 202;
  //     if (repo.statusCode == codeNotExpired) {
  //       return Success(code: codeNotExpired);
  //     }
  //     return Failure();
  //   } catch (e) {
  //     return Failure();
  //   }
  // }

  static Future<Object> postOptCode(int code, String token) async {
    // handle errors

    final url = Uri.parse(baseUrl + "/opt");
    try {
      final repo = await http.post(url,
          body: jsonEncode({"opt_code": code}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": " Bearer $token"
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
