import 'package:shop_app/cart/model/Cart.dart';

class CheckoutModel {
  final List<Cart> listCartModel;
  final double totalPrice;
  final String timePay;

  CheckoutModel(
      {required this.listCartModel,
      required this.totalPrice,
      required this.timePay});
}
