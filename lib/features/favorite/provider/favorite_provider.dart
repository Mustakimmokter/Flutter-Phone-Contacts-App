import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';

class FavoriteProvider extends ChangeNotifier {


  final List<ContactInfo> _contactList = [
    ContactInfo(
      name: 'Mustakim Mokter fggfgfdgfdgfgdgdg'
    ),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
  ];

  final bool _isTrue = true;

  final int _selectedIndex = -0;


  bool get isTrue => _isTrue;
  int get selectedIndex => _selectedIndex;
  List<ContactInfo> get contactList => _contactList;

  void getIsTrue(int index){
   contactList[index].isSelected =! contactList[index].isSelected;
    notifyListeners();
    print(contactList[index].isSelected);
  }

}