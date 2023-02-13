import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';

class BodyProvider extends ChangeNotifier {


  final List<ContactInfo> _contactList = [
    ContactInfo(
      name: 'Saddam',
      number: '01732-237185'
    ),
    ContactInfo(
      name: 'Mishu',
      number: '0184163069',
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
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
  ];final

  bool _isTrue = true;



  bool get isTrue => _isTrue;
  List<ContactInfo> get contactList => _contactList;

  void getIsTrue(int index){
   contactList[index].isSelected =! contactList[index].isSelected;
    notifyListeners();
    print(contactList[index].isSelected);
  }

}