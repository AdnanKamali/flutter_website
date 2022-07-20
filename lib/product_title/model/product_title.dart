import 'dart:convert';

import 'package:shop_app/product/model/model.dart';

List<ProductTitleModel> productTitleListModelFromJson(String str) =>
    List.from(json
        .decode(str)["list"]
        .map((productTitle) => ProductTitleModel.fromJson(productTitle)));

List<ProductModel> productListModelFromJson1(dynamic str) {
  return List.from(str.map((element) {
    return ProductModel.fromJson(element);
  }));
}

class ProductTitleModel {
  ProductTitleModel({required this.name, required this.productListModel});

  final String name;
  final List<ProductModel> productListModel;

  factory ProductTitleModel.fromJson(Map<String, dynamic> json) {
    final productListModel = productListModelFromJson1(json["products"]);
    return ProductTitleModel(
        name: json["name"], productListModel: productListModel);
  }
}
