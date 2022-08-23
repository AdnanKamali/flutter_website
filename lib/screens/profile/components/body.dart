import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/about_us/about_us_screen.dart';
import 'package:shop_app/screens/checkouts/checkouts_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import 'package:shop_app/viewModel/user_view_model.dart';
import 'dart:html' as html;
import 'profile_menu.dart';
import 'profile_pic.dart';
// import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    final userModel = Provider.of<UserViewModel>(context).userModel;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(
              fullName: userModel.firstName! + " " + userModel.lastName!,
              phoenNumber: userModel.phoneNumber!),
          SizedBox(height: 20),
          ProfileMenu(
            text: translate("checkouts"),
            icon: "icons/checkouts.svg",
            press: () {
              // push to checkouts screen
              Navigator.of(context).pushNamed(CheckoutsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: translate("about us"),
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.of(context).pushNamed(AboutUsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: translate("logout"),
            icon: "assets/icons/Log out.svg",
            press: () async {
              final localStorage = await SharedPreferences.getInstance();
              await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.start,
                  title: Text(translate("log out")),
                  actions: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                      onPressed: () async {
                        final isClearDataStorage = await localStorage.clear();
                        if (isClearDataStorage) {
                          html.window.location.reload();
                        }
                      },
                      child: Text(
                        translate("exit"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
