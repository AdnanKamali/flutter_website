import 'package:flutter/material.dart';
import 'package:shop_app/responsive.dart';
import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.isDesktop(context)
          ? getProportionateScreenHeight(56) + 20
          : Responsive.isTablet(context)
              ? getProportionateScreenHeight(56) + 15
              : getProportionateScreenHeight(56) + 10,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: press != null ? kPrimaryColor : Colors.grey.shade400,
        ),
        onPressed: press,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
