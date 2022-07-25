import 'package:shop_app/cart/model/Cart.dart';

class CheckoutModel {
  final List<Cart>? listCartModel;
  final double? totalPrice;
  String? address;
  int? phoneNumber;

  CheckoutModel({
    this.listCartModel,
    this.totalPrice,
    required this.address,
    required this.phoneNumber,
  });
  Map<String, dynamic> toJson() => {
        "address": address,
        "phone_number": phoneNumber,
      };
}
