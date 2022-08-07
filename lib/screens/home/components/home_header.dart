import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import '../../../size_config.dart';
import '../../profile/profile_screen.dart';
import 'icon_btn_with_counter.dart';
// import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    final translate = DemoLocalizations.of(context).translate;
    // userViewModel.setUsernameLogedIn();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () async {
              final isLogedIn = userViewModel.accessToken != null;
              if (isLogedIn) {
                // get from server
                Navigator.pushNamed(context, ProfileScreen.routeName);
              } else {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
            child: Text(userViewModel.userModel.username ??
                "${translate("login")}/${translate("signUp")}"),
            style: TextButton.styleFrom(
              side: BorderSide(width: 0.5, color: Colors.blue),
              padding: EdgeInsets.all(22),
            ),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: cartViewModel.cartListModel.length,
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}
