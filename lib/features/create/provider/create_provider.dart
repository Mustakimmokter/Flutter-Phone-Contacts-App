import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProvider extends ChangeNotifier {

  late bool _isFavorite = false;
  bool? get isFavorite => _isFavorite;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file;

  String? _image;
  String? get image => _image;

  Future<void> getImagePicker()async{
    _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(_file != null){
      _image = _file!.path;
    }
    notifyListeners();
  }

  void getFavorite(bool value){
    _isFavorite  = value;
    notifyListeners();
  }

}