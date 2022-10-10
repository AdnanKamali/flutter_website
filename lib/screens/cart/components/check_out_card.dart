import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
// import 'package:shop_app/viewModel/checkout_view_model.dart';

import '../../../size_config.dart';
import 'first_page_inputs.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "${translate("totalPrice")}:\n",
                    children: [
                      TextSpan(
                        text: "$totalPrice IRR",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: translate("checkout"),
                    press: () => onCheckoutButton(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onCheckoutButton(BuildContext context) async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    final translate = DemoLocalizations.of(context).translate;
    if (cartViewModel.cartListModel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(translate("cart is empty")),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }
    final isLogin = cartViewModel.accessToken != null;
    if (isLogin) {
      await checkoutModalBottmSheet(context);
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      Navigator.of(context).pushNamed(SignInScreen.routeName);
    }
  }

  Future<dynamic> checkoutModalBottmSheet(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    // final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    // final translate = DemoLocalizations.of(context).translate;
    return showModalBottomSheet(
      isScrollControlled: true,
      // useRootNavigator: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (ctx) => FirstPageCheckoutInformation(),
    );
  }
}
