import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_contact_app/features/my_profile/ui/screen/profile_screen.dart';
import 'package:phone_contact_app/shared/db/local_db.dart';
import 'package:phone_contact_app/shared/db/table.dart';

class AuthService extends ChangeNotifier {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get userNumber => _auth.currentUser!.phoneNumber!;


  bool _isVerifiedSuccess = false;
  bool get isVerifiedSuccess => _isVerifiedSuccess;


  bool _isOTPError = false;
  bool get isOTPError => _isOTPError;

  String? _timeOutVerification;
  String? get timeOutVerification => _timeOutVerification;

  bool _isLoadAndUpdate = false;
  bool get isLoadAndUpdate => _isLoadAndUpdate;

  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;

  bool _isSignOut = true;
  bool get isSignOut => _isSignOut;

   // Phone Number Verified
  Future<void> phoneNumberVerification(String phnNumber,BuildContext context,String resend)async{
     _isOTPError = false;
    _isSignIn = true;
     notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: '+88 $phnNumber',
      verificationCompleted: (PhoneAuthCredential credential) {

      },
      verificationFailed: (FirebaseAuthException e) {
        _isSignIn = false;
        notifyListeners();
        final params = {'verificationID': '333494','phoneNumber': phnNumber};
       Navigator.pushNamed(context, '/otpScreen',arguments: params);
      },
      codeSent: (String verificationId, int? resendToken)async{
        _isSignIn = false;
        notifyListeners();

        final params = {'verificationID': verificationId,'phoneNumber': phnNumber};

        if(resend == 'Resend'){
        }else{
          Navigator.pushNamed(context, '/otpScreen',arguments: params);
        }
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
       _timeOutVerification = verificationId;
       notifyListeners();
        print('TimeOut...................');
      },
    );

  }

  // After verified then login with phone number or create new user
  Future<void> signInWithPhoneNumber(String number,String verificationId,String smsCode,BuildContext context)async{
     _isVerifiedSuccess = true;
    _isOTPError = false;
    notifyListeners();
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      if(_auth.currentUser!.uid.isNotEmpty){
        final params = {'number': _auth.currentUser!.phoneNumber};
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>UserState(number : params['number'].toString())), (route) => false);
        Fluttertoast.showToast(msg: 'Successful login');
        final userData = {'phoneNumber': _auth.currentUser!.phoneNumber,'OTP': smsCode};
        String userDataEnCoded = jsonEncode(userData);
        DbHelper.saveData(DbTable.userInfo, DbTable.userInfo, userDataEnCoded);
        _isVerifiedSuccess = false;
        notifyListeners();

      }
    }catch(error){
      _isVerifiedSuccess = false;
      _isOTPError = true;
      notifyListeners();
      print('try again');
    }
  }

  Future<void> singOut(BuildContext context)async{
     _isSignOut = false;
     notifyListeners();
     Navigator.pushNamedAndRemoveUntil(context, '/signIn', (route) => false);
     try {
       await _auth.signOut();
         DbHelper.deleteData(DbTable.userInfo);
         Future.delayed(const Duration(milliseconds: 300),(){
           _isSignOut = true;
           notifyListeners();
         });


     } catch (e) {
       print('Error:...............$e..................');
     }
  }

  void getLoadAndUpdate(bool value){
    _isLoadAndUpdate = value;
    notifyListeners();
  }


}