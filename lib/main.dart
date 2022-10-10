import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/route_generator.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import 'package:shop_app/theme.dart';
import 'package:shop_app/utils/localzations/delegate.dart';
import 'package:shop_app/utils/resource_manager/timer.dart';
import 'package:shop_app/viewModel/banner_changer.dart';
import 'package:shop_app/viewModel/cart_view_model.dart';
import 'package:shop_app/viewModel/checkout_view_model.dart';
import 'package:shop_app/viewModel/error_handler_view_model.dart';
import 'package:shop_app/viewModel/product_view_model.dart';
import 'package:shop_app/viewModel/token_view_model.dart';
import 'package:shop_app/viewModel/user_view_model.dart';
import 'package:shop_app/viewModel/widget_view_manager.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => WidgetManager(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => BannerChanger(),
      ),
      ChangeNotifierProvider(
        create: (_) => ErrorHandlerViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TokenViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TimerSecond(),
      ),
      ChangeNotifierProxyProvider<TokenViewModel, CartViewModel>(
        create: (_) => CartViewModel(),
        update: (ctx, tokenViewModel, cartViewModel) =>
            CartViewModel(tokenViewModel: tokenViewModel),
      ),
      ChangeNotifierProxyProvider2<TokenViewModel, WidgetManager,
          UserViewModel>(
        create: (_) => UserViewModel(),
        update: (_, tokenViewModel, widgetManager, userViewModel) =>
            userViewModel!
              ..setTokenViewModel(tokenViewModel)
              ..setWidgetManager(widgetManager),
      ),
      ChangeNotifierProxyProvider<TokenViewModel, CheckoutViewModel>(
        create: (_) => CheckoutViewModel(),
        update: (ctx, tokenViewModel, checkoutViewModel) =>
            checkoutViewModel!..setTokenViewModel(tokenViewModel),
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
      // home: Center(child: SizedBox(height: 30, child: ThreeDotLoading())),
      onGenerateRoute: RouteGenerator.generaterRoute,
    );
  }
}
