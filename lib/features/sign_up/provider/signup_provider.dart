import 'package:flutter/material.dart';


class SignupProvider extends ChangeNotifier {

  bool _isCheckVisible = false;
  bool _isPasswordVisible = true;


  bool get isCheckVisible => _isCheckVisible;
  bool get isPasswordVisible => _isPasswordVisible;


  void getPasswordVisible(){
  _isPasswordVisible =! _isPasswordVisible;
    notifyListeners();
  }



}