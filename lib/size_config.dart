import 'package:flutter/material.dart';
import 'package:shop_app/responsive.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static bool? isDesktop;
  static bool? isTablet;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    isDesktop = Responsive.isDesktop(context);
    isTablet = Responsive.isTablet(context);
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  if (SizeConfig.isDesktop!) return (inputHeight / 1080.0) * screenHeight;
  if (SizeConfig.isTablet!) return (inputHeight / 965.0) * screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// height 812 for mobile
// height 1080 for desktop

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  if (SizeConfig.isDesktop!) return (inputWidth / 920.0) * screenWidth;
  if (SizeConfig.isTablet!) return (inputWidth / 650.0) * screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// width 375 mobile
// width 920 desktop