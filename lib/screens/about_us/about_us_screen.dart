import 'package:flutter/material.dart';
import 'package:shop_app/screens/about_us/components/content.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static const String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.yellow.shade100, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Content(),
      ),
    );
  }
}
