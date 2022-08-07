import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "We are a new compony for make artifical wall\n"),
                TextSpan(text: "from 1998 when word curvl\n"),
                TextSpan(text: "lorem episom for all text is already\n"),
                TextSpan(
                    text: "ich bin sehr klug und da essen ist zu lecker\n"),
              ],
            ),
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "Compony: +98 917 123 4567",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "creator: +98 917 987 6543",
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
