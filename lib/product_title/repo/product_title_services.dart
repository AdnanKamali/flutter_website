import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/product_title/model/product_title.dart';
import 'package:shop_app/utils/resource_manager/url_manager.dart';

import '../../utils/resource_manager/error_manager.dart';

class ProductTitleServices {
  static Future<Object> getTitles() async {
    final url = Uri.parse(UrlManager.allProductWithTitle.url);
    try {
      final repo = await http.get(url);
      if (repo.statusCode == 200) {
        final response = productTitleListModelFromJson(repo.body);
        return Success(response: response);
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
