import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return _ui(
      cartViewModel,
      buildAppBar(context, cartViewModel.cartListModel.length),
    );
  }

  AppBar buildAppBar(BuildContext context, int length) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "$length items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

Widget _ui(CartViewModel cartViewModel, AppBar appBar) {
  return Scaffold(
    appBar: appBar,
    body: Body(
      cartViewModel: cartViewModel,
    ),
    bottomNavigationBar: CheckoutCard(totalPrice: cartViewModel.totalCartPrice),
  );
}
