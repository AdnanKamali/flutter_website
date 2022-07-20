import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
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
  final String cociey = "Hellow";
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.setUsernameLogedIn();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          // Container(
          //   padding: EdgeInsets.all(getProportionateScreenWidth(6)),
          //   height: getProportionateScreenWidth(44),
          //   width: getProportionateScreenWidth(44),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     border: Border.all(color: Colors.grey),
          //   ),
          //   child: IconButton(
          //       icon: SvgPicture.asset(
          //         "assets/icons/User Icon.svg",
          //         height: getProportionateScreenWidth(46),
          //         width: getProportionateScreenWidth(46),
          //       ),
          //       onPressed: () {
          //         if (cociey == "Hello") {
          //           // get from server
          //           Navigator.pushNamed(context, ProfileScreen.routeName);
          //         } else {
          //           Navigator.pushNamed(context, SignInScreen.routeName);
          //         }
          //       }),
          // ),
          TextButton(
            onPressed: () async {
              final refresh_token = await SharedPreferences.getInstance();
              if (refresh_token.getString("refresh_token") != null) {
                // get from server
                Navigator.pushNamed(context, ProfileScreen.routeName);
              } else {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
            child: Text(userViewModel.userModel.username ?? "Login/Sign Up"),
            style: TextButton.styleFrom(
              side: BorderSide(width: 0.5, color: Colors.blueGrey),
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
