import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/responsive.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/error_handler_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../utils/resource_manager/widgets.dart';
import '../../profile/profile_screen.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    Key? key,
  }) : super(key: key);

  // int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final errorViewModel = Provider.of<ErrorHandlerViewModel>(context);
    final translate = DemoLocalizations.of(context).translate;
    final isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () async {
              final isLogedIn = userViewModel.tokenViewModel!.isLogedIn;
              if (isLogedIn) {
                // get from server
                Navigator.pushNamed(context, ProfileScreen.routeName);
              } else {
                await sign_up(context, [
                  phoneNumberPageLogin(userViewModel, translate, context),
                  confirmPhoneNumber(userViewModel, translate),
                  signUpFullName(userViewModel, translate)
                ]).then((value) {
                  userViewModel.pageChanger(0);
                  userViewModel.backToDefualt();
                  errorViewModel.backToDefualt();
                });
                // Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
            child: Text(
              userViewModel.userModel.firstName == null
                  ? "${translate("login")}/${translate("signUp")}"
                  : (userViewModel.userModel.firstName! +
                      " " +
                      userViewModel.userModel.lastName!),
              maxLines: 1,
              style: TextStyle(
                color: userViewModel.userModel.firstName == null
                    ? kPrimaryColor
                    : Colors.white,
                fontSize: isDesktop ? null : 10,
              ),
            ),
            style: TextButton.styleFrom(
              maximumSize: Size(MediaQuery.of(context).size.width * 0.34, 60),
              backgroundColor: userViewModel.userModel.firstName == null
                  ? null
                  : kPrimaryColor,
              side: BorderSide(
                  width: 0.5,
                  color: userViewModel.userModel.firstName == null
                      ? kPrimaryColor
                      : Colors.white),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: kPrimaryColor),
              padding: EdgeInsets.all(22),
            ),
          ),
          IconBtnWithCounter(
            color: kPrimaryColor,
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: cartViewModel.cartListModel.length,
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}
