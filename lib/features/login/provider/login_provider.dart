import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  bool _isCheckVisible = false;
  bool _isPasswordVisible = true;


  bool get isCheckVisible => _isCheckVisible;
  bool get isPasswordVisible => _isPasswordVisible;


  void getCheckVisible(String number){
    if(number.isNotEmpty && number != null && number.length > 10){
      _isCheckVisible = true;
      notifyListeners();
    }else{
      _isCheckVisible = false;
      notifyListeners();
    }
  }

  void getPasswordVisible(){
  _isPasswordVisible =! _isPasswordVisible;
    notifyListeners();
  }


  Future<void> getPhoneAuth(String number)async{
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }



}

