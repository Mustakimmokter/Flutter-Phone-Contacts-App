import 'package:flutter/material.dart';

class SizeUtils {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontalPadding;
  static late double blockSizeVerticalPadding;
  static late double _safeAreaHorizontalPadding;
  static late double _safeAreaVerticalPadding;
  static late double safeBlockHorizontalPadding;
  static late double safeBlockVerticalPadding;
  static late double topPadding;
  static bool hasBottomViewPort = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontalPadding = screenWidth / 100;
    blockSizeVerticalPadding = screenHeight / 100;
    topPadding = _mediaQueryData.padding.top;

    _safeAreaHorizontalPadding =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVerticalPadding =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontalPadding =
        (screenWidth - _safeAreaHorizontalPadding) / 100;
    safeBlockVerticalPadding = (screenHeight - _safeAreaVerticalPadding) / 100;
    hasBottomViewPort = _mediaQueryData.viewInsets.bottom != 0;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    final screenHeight = SizeUtils.screenHeight;

    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    final screenWidth = SizeUtils.screenWidth;

    return (inputWidth / 375.0) * screenWidth;
  }
}
