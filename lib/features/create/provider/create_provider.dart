import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProvider extends ChangeNotifier {

  bool _isCheck = false;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file;
  String? _image;

  bool get isCheck => _isCheck;
  String? get image => _image;

  void getCheck(value){
    _isCheck =! _isCheck;
    notifyListeners();
  }

  Future<void> getImagePicker()async{
    _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(_file != null){
      _image = _file!.path;
    }
    notifyListeners();
  }

}