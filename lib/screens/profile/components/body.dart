import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/about_us/about_us_screen.dart';
import 'package:shop_app/screens/checkouts/checkouts_screen.dart';
import 'dart:html' as html;
import 'profile_menu.dart';
// import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Checkouts",
            icon: "assets/icons/Question mark.svg",
            press: () {
              // push to checkouts screen
              Navigator.of(context).pushNamed(CheckoutsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "About Us",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.of(context).pushNamed(AboutUsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              final localStorage = await SharedPreferences.getInstance();
              await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Are You Sure Log Out?"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("No")),
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () async {
                          final isClearDataStorage = await localStorage.clear();
                          if (isClearDataStorage) {
                            html.window.location.reload();
                          }
                        },
                        child: Text("Yes")),
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
