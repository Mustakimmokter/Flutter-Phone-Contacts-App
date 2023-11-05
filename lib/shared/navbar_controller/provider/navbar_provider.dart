import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void getSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }



}