import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/utils/helper/validate_function.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "$totalPrice Rial",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      final localStorage =
                          await SharedPreferences.getInstance();
                      final isLogin = localStorage.getString("refresh_token");
                      if (isLogin != null)
                        await checkoutModalBottmSheet(context);
                      else {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                        Navigator.of(context).pushNamed(SignInScreen.routeName);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> checkoutModalBottmSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final PageController pageController = PageController();
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (ctx) => Consumer<CheckoutViewModel>(
        builder: (context, checkoutViewModel, child) => PageView(
          controller: pageController,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _phoneNumberFormField(checkoutViewModel),
                    _addressFormField(checkoutViewModel),
                    ElevatedButton(
                      onPressed: () => submitButton(
                          checkoutViewModel, pageController, _formKey),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Checkout"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // use future builder instead this
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      maxLength: 4,
                      onChanged: (value) {
                        final tryToInt = int.tryParse(value);
                        if (tryToInt != null) {
                          if (value.length == 4) {
                            checkoutViewModel
                                .setIsEnableSubmitButtonOptCode(true);
                          } else {
                            checkoutViewModel
                                .setIsEnableSubmitButtonOptCode(false);
                          }
                        }
                      },
                      decoration: InputDecoration(
                          counterText: "", hintText: "Enter Opt code"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: checkoutViewModel.isEnableSubmitButtonOptCode
                      ? () async {
                          final result =
                              await checkoutViewModel.postOptCode(2035);
                        }
                      : null,
                  child: Text("Confirm"),
                )
              ],
            ),
            Text("Success message") // insert success widget
          ],
        ),
      ),
    );
  }

  TextFormField _phoneNumberFormField(CheckoutViewModel checkoutViewModel) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "Phone Number", hintTextDirection: TextDirection.rtl),
      validator: Validator.phoneNumber,
      onSaved: checkoutViewModel.savePhoneNumber,
    );
  }

  TextFormField _addressFormField(CheckoutViewModel checkoutViewModel) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Address",
        hintTextDirection: TextDirection.rtl,
        alignLabelWithHint: true,
      ),
      validator: Validator.address,
      onSaved: checkoutViewModel.saveAddress,
    );
  }

  void submitButton(CheckoutViewModel checkoutViewModel,
      PageController pageController, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      // not validate form
      return;
    }
    // send to server
    formKey.currentState!.save();
    final post = await checkoutViewModel.postCheckoutToPay();
    print(post);
    checkoutViewModel.changeView(pageController);
  }
}
