import 'package:flutter/material.dart';
import 'package:shop_app/route_generator.dart';
import 'package:shop_app/routes.dart';
import 'dart:html' as html;
// import 'package:shop_app/screens/profile/profile_screen.dart';
// import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

import 'screens/home/home_screen.dart';
import 'size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // html.window.onUnload.listen(
    //   (event) {
    //     SizeConfig().init(context);
    //   },
    // );
    print("Run Agian");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generaterRoute,
    );
  }
}
