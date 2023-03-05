import 'package:flutter/material.dart';

class AppSizes {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = AppSizes.screenHeight;
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = AppSizes.screenWidth;
    return (inputWidth / 375.0) * screenWidth;
  }
}
