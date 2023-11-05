import 'package:flutter/material.dart';

class DetailsProvider extends ChangeNotifier {

  bool _isEdited = false;
  bool get isEdited => _isEdited;

  void getIsEdited(bool val){
    _isEdited = val;
    notifyListeners();
  }

}