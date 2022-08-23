import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/utils/localzations/demo_localzations.dart';

import '../../../size_config.dart';

// TODO: move string to language json

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontFamily: "IranSans",
            color: Colors.black,
          ),
        ),
        // IconButton(
        //   onPressed: press,
        //   icon: Icon(
        //     Icons.arrow_forward_ios_rounded,
        //   ),
        //   color: kPrimaryColor,
        // ),
        GestureDetector(
          onTap: press,
          child: Text(
            "بیشتر",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}
