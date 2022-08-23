import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';
import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translate = DemoLocalizations.of(context).translate;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            translate("sign up now"),
            style: TextStyle(fontSize: getProportionateScreenWidth(14)),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            translate("sign up"),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
