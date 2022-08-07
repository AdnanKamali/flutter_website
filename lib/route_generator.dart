import 'package:flutter/material.dart';
import 'package:shop_app/screens/about_us/about_us_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/checkouts/checkouts_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';

import 'screens/sign_in/sign_in_screen.dart';

class RouteGenerator {
  static Route<dynamic> generaterRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/forgot_password":
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case "/login_success":
        return MaterialPageRoute(builder: (_) => LoginSuccessScreen());
      case "/sign_up":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/sign_in":
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case "/complete_profile":
        return MaterialPageRoute(builder: (_) => CompleteProfileScreen());
      case "/otp":
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case "/details":
        final detailsArg = args as ProductDetailsArguments;
        return MaterialPageRoute(builder: (_) => DetailsScreen(detailsArg));
      case "/cart":
        return MaterialPageRoute(builder: (_) => CartScreen());
      case "/profile":
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case "/checkout-screen":
        return MaterialPageRoute(builder: (_) => CheckoutsScreen());
      case "/about":
        return MaterialPageRoute(builder: (_) => AboutUsScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
