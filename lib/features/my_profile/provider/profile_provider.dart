
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file;
  String? _image;
  bool _isShowPassword = true;

  String? get image => _image;
  bool get isShowPassword => _isShowPassword;

  Future<void> getPickImage()async{
    _file = await _imagePicker.pickImage(source: ImageSource.gallery);
   if(_file != null){
     _image = _file!.path;
   }
    notifyListeners();
  }

  void getShowPassword(bool val){

    _isShowPassword = val;
    notifyListeners();
  }

}