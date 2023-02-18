import 'package:flutter/material.dart';


class SignupProvider extends ChangeNotifier {

  bool _isCheckVisible = false;
  bool _isPasswordVisible = true;


  bool get isCheckVisible => _isCheckVisible;
  bool get isPasswordVisible => _isPasswordVisible;


  void getCheckVisible(String number){
    if(number.length > 10){
      _isCheckVisible = true;
      notifyListeners();
    }else{
      _isCheckVisible = false;
      notifyListeners();
      print('not');
    }
  }

  void getPasswordVisible(){
  _isPasswordVisible =! _isPasswordVisible;
    notifyListeners();
  print(_isPasswordVisible);
  }



}