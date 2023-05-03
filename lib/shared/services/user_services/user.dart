import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_contact_app/shared/models/use_model.dart';

class UserService extends ChangeNotifier {

  UserModel? userModel;

 Future<void> getProfile()async{
   FirebaseAuth auth = FirebaseAuth.instance;
   User? currentUser = auth.currentUser;
   if (currentUser != null) {
     userModel = UserModel(
       name: currentUser.displayName,
       email: currentUser.email,
       photoUrl: currentUser.photoURL,
     );
     notifyListeners();
   }


 }

}