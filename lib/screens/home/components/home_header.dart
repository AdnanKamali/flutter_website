import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

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
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(6)),
            height: getProportionateScreenWidth(44),
            width: getProportionateScreenWidth(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                height: getProportionateScreenWidth(46),
                width: getProportionateScreenWidth(46),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
            ),
          ),

          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: 2,
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}
