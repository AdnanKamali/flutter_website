import 'package:flutter/material.dart';
import 'package:shop_app/screens/about_us/components/content.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static const String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Content(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.blueGrey.withOpacity(0.1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }
}
