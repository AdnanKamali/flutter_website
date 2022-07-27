import 'package:flutter/material.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
// import 'package:shop_app/enums.dart';

import '../../size_config.dart';
import '../../utils/resource_manager/url_manager.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Body(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    UrlManager.images.url + "/" + "background_img.webp"),
                fit: BoxFit.cover)),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
