import 'dart:io';

import '../../utils/resource_manager/error_manager.dart';
import '../../utils/resource_manager/url_manager.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;

import 'api_status.dart';

class ProductServices {
  static Future<Object> getProducts() async {
    try {
      final url = Uri.parse(UrlManager.allProduct.url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final res = productListModelFromJson(response.body);
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
