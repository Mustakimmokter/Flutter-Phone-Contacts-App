import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class LoginProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  bool _isCheckVisible = false;
  bool _isPasswordVisible = true;


  bool get isCheckVisible => _isCheckVisible;
  bool get isPasswordVisible => _isPasswordVisible;



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




  // void startAnimation() {
  //   controller = AnimationController(
  //     vsync: _tickerProvider!,
  //     duration: const Duration(seconds: 1),
  //   );
  //   controller2 = AnimationController(
  //     vsync: _tickerProvider!,
  //     duration: const Duration(seconds: 2),
  //   );
  //   notifyListeners();
  //   final curvedAnimation = CurvedAnimation(
  //     parent: controller!,
  //     curve: Curves.ease,
  //   );
  //   animationSize = Tween(begin: 0.0, end: 80.0).animate(curvedAnimation)..addListener(() {
  //     notifyListeners();
  //   });
  //   animationSize2 = Tween(begin: 0.0,end: 50).animate(curvedAnimation)..addListener(() {notifyListeners(); });
  //   animationColor = ColorTween(begin: Colors.red,end: Colors.green).animate(curvedAnimation)..addListener(() {
  //     notifyListeners();
  //   });
  //
  //   controller!.repeat();
  //   controller2!.repeat();
  //   print(animationSize!.value);
  //
  // }


}

