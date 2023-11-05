import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {

  void initCall({required Function onPressed}){
    Future.delayed(const Duration(seconds: 1),(){
    onPressed();
    });
  }
}