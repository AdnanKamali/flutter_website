import 'dart:convert';

import 'package:shop_app/cart/model/Cart.dart';

List<CheckoutModel> checkoutListModelFromJson(String str) =>
    List.from(jsonDecode(str)["buies"].map((checkoutModel) {
      return CheckoutModel.fromJson(checkoutModel);
    }));

class CheckoutModel {
  final int? id;
  final List<Cart>? cartListModel;
  final double? totalPrice;
  String? address;

  CheckoutModel({
    this.cartListModel,
    this.totalPrice,
    this.id,
    required this.address,
  });
  Map<String, dynamic> toJson() => {
        "address": address,
      };
  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    double _totalPrice = 0;
    final _cartListModel =
        cartListModelFromJson(jsonEncode({"carts": json["carts"]}));
    for (final cart in _cartListModel) {
      _totalPrice += (cart.numOfItem! * cart.product!.price);
    }

    return CheckoutModel(
      id: json["id"],
      address: json["address"],
      cartListModel: _cartListModel,
      totalPrice: _totalPrice,
    );
  }
}
