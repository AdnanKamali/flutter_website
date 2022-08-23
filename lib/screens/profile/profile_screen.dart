import 'package:flutter/material.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
// import 'package:shop_app/enums.dart';

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
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
