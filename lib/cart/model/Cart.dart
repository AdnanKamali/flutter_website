import 'dart:convert';

import '../../product/model/model.dart';

List<Cart> cartListModelFromJson(String str) => List.from(
    jsonDecode(str)["carts"].map((element) => Cart.fromJson(element)));

class Cart {
  int? id;
  ProductModel? product;
  int? color;
  int? numOfItem;

  Cart.base({this.id, this.product, this.color, this.numOfItem});

  Cart(
      {required this.id,
      required this.product,
      required this.numOfItem,
      this.color});

  factory Cart.fromJson(Map<String, dynamic> json) {
    final product = ProductModel.fromJson(json["product"]);
    return Cart(
        id: json["id"],
        product: product,
        numOfItem: json["product_count"],
        color: json["color"]);
  }
  Map<String, dynamic> toJson() {
    final json = {
      "product_id": product?.id,
      "product_count": numOfItem,
      "color": color
    };
    return json;
  }
}
