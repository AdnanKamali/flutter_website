import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/screens/cart/components/body.dart' as body;

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return _ui(
      cartViewModel,
      buildAppBar(context, cartViewModel.cartListModel.length, cartViewModel),
    );
  }

  AppBar buildAppBar(
      BuildContext context, int length, CartViewModel cartViewModel) {
    final translate = DemoLocalizations.of(context).translate;
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              body.Body.showHelpDialog(context, cartViewModel);
            },
          ),
        )
      ],
      title: Column(
        children: [
          Text(
            translate("carts"),
            style: TextStyle(color: Colors.black87),
          ),
          Text(
            "${translate("cartCount")} $length",
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
