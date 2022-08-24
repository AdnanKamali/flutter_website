import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate("profile"),
          style: TextStyle(
              color: Colors.red,
              fontFamily: "IranSans",
              fontSize: getProportionateScreenWidth(14)),
        ),
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
