import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {

  int _selectedIndex = 0;

  bool _isCheck = false;

  bool get isCheck => _isCheck;

  void getCheck(value){
    _isCheck =! _isCheck;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  void getSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }



}