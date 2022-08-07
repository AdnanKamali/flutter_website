import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/cart/components/second_page_opt_code_input.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';

import '../../../constants.dart';
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
                        text: "${translate("rial")} $totalPrice",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
    if (cartViewModel.cartListModel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Cart Is Empty"),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }
    // final localStorage = await SharedPreferences.getInstance();
    // final isLogin = localStorage.getString("refresh_token");
    final isLogin = cartViewModel.accessToken != null;
    if (isLogin) {
      await checkoutModalBottmSheet(context);
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      Navigator.of(context).pushNamed(SignInScreen.routeName);
    }
  }

  Future<dynamic> checkoutModalBottmSheet(BuildContext context) {
    late PageController pageController;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (ctx) => Consumer<CheckoutViewModel>(
        builder: (context, checkoutViewModel, child) => FutureBuilder(
            future: checkoutViewModel.getIsAvalableCode(),
            builder: (context, isCodeAvailble) {
              if (isCodeAvailble.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (isCodeAvailble.data as bool) {
                pageController = PageController(initialPage: 1);
              } else {
                pageController = PageController();
              }
              return PageView(
                controller: pageController,
                children: [
                  // use future builder instead this
                  FirstPageCheckoutInformation(pageController: pageController),
                  SecondPageCheckoutOtp(),
                  Text("Success message") // insert success widget
                ],
              );
            }),
      ),
    );
  }
}
