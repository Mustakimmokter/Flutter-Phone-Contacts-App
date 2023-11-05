import 'dart:io';

import 'package:flutter/material.dart';

class UserProfile {

  // profile image
  static DecorationImage decorationImage(dynamic networkPhoto,[String selectPhoto = '']){
    if( selectPhoto != '' && selectPhoto.isNotEmpty){
      return DecorationImage(image: FileImage(File(selectPhoto)),fit: BoxFit.cover);

    }else if(networkPhoto['photoUrl'] != '' && networkPhoto['photoUrl'] != 'noPhoto'){
      return DecorationImage(image: NetworkImage(networkPhoto['photoUrl']!),fit: BoxFit.cover);

    }else{
      return const DecorationImage(image: AssetImage('assets/icons/person-icon.png'),scale: 12);
    }
  }

}