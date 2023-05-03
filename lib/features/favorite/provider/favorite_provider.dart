import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';

class FavoriteProvider extends ChangeNotifier {


  final List<Contacts> _contactList = [
    Contacts(
      name: 'Mustakim Mokter fggfgfdgfdgfgdgdg'
    ),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
    Contacts(),
  ];

  final bool _isTrue = true;

  final int _selectedIndex = -0;


  bool get isTrue => _isTrue;
  int get selectedIndex => _selectedIndex;
  List<Contacts> get contactList => _contactList;

  void getIsTrue(int index){
   contactList[index].isSelected =! contactList[index].isSelected;
    notifyListeners();
    print(contactList[index].isSelected);
  }

}