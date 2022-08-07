import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/route_generator.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import 'package:shop_app/theme.dart';
import 'package:shop_app/utils/localzations/delegate.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';
import 'package:shop_app/viewModel/product_view_model.dart';
import 'package:shop_app/viewModel/token_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ProductViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TokenViewModel(),
      ),
      ChangeNotifierProxyProvider<TokenViewModel, CartViewModel>(
        create: (_) => CartViewModel(),
        update: (ctx, tokenViewModel, cartViewModel) =>
            CartViewModel(tokenViewModel: tokenViewModel),
      ),
      ChangeNotifierProxyProvider<TokenViewModel, UserViewModel>(
        create: (_) => UserViewModel(),
        update: (ctx, tokenViewModel, cartViewModel) =>
            UserViewModel(tokenViewModel: tokenViewModel),
      ),
      ChangeNotifierProxyProvider<TokenViewModel, CheckoutViewModel>(
        create: (_) => CheckoutViewModel(),
        update: (ctx, tokenViewModel, cartViewModel) =>
            CheckoutViewModel(tokenViewModel: tokenViewModel),
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
      supportedLocales: [
        const Locale("fa", "IR"),
      ],
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode ||
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      // We use routeName so that we dont need to remember the name
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generaterRoute,
    );
  }
}
