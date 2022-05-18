import 'package:flutter/material.dart';
import 'package:shop_app/route_generator.dart';

import 'package:shop_app/theme.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // We use routeName so that we dont need to remember the name
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generaterRoute,
    );
  }
}
