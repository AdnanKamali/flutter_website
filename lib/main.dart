import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/route_generator.dart';

import 'package:shop_app/theme.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/product_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ProductViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserViewModel(),
      ),
    ],
    child: MyApp(),
  ));
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
