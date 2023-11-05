
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_contact_app/shared/db/table.dart';


class ProfileProvider extends ChangeNotifier {

  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;


  bool _isCameraAndGallery = false;
  bool get isCameraAndGallery => _isCameraAndGallery;

  bool _isProfilePicDone = true;
  bool get isProfilePicDone => _isProfilePicDone;


  String _image = '';
  String get image => _image;


  Future<void> getPickImage(String galleryAndCamera)async{
    final XFile? file;
    _isCameraAndGallery = false;
    notifyListeners();
   if(galleryAndCamera == 'camera'){
     file = await _imagePicker.pickImage(source: ImageSource.camera,imageQuality: 40);
     if(file != null){
       _image = file.path;
       notifyListeners();

     }
   }else{
     file = await _imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 40);
     if(file != null){
       _image = file.path;
       notifyListeners();
     }
   }
  }

  void getCameraOrGallery(bool value){
    _isCameraAndGallery = value;
    notifyListeners();
  }

  void getNameValue(name){
    _nameController = TextEditingController(text: name);
    notifyListeners();
  }

  Future<void> upLoadProfilePic(String image)async{
   getProfilePicDone(false);
    final currentUser = FirebaseAuth.instance.currentUser;
    try{
      if(image.isNotEmpty){
        Reference reference = FirebaseStorage.instance.ref(FirebaseTable.userProfile).child('${currentUser!.phoneNumber}.jpg');
        await reference.putFile(File(image),);
        getProfilePicDone(true);
      }
    }catch(e){
      getProfilePicDone(true);
      //print('Try again');
    }
  }

  void getProfilePicDone(val){
    _isProfilePicDone = val;
    notifyListeners();
  }

  void imageDispose(){
      _image = '';
      notifyListeners();
  }

}