
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_contact_app/features/db/local_db.dart';
import 'package:phone_contact_app/features/db/table.dart';
import 'package:phone_contact_app/shared/models/use_model.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:pinput/pinput.dart';
import '../../../features/home/ui/screen/home_screen.dart';

class AuthService extends ChangeNotifier {
  AuthService(){
    getUserProfile();
  }

  TextEditingController? nameCTRL;
  final TextEditingController emailCTRL = TextEditingController(text: 'mustakimmokter@gmail.com');
  final TextEditingController passwordCTRL = TextEditingController(text: '123456789012');


  FirebaseAuth auth = FirebaseAuth.instance;

  final ImagePicker _imagePicker = ImagePicker();
  UserModel? _userProfile;
  String? _id;



  bool _isSignup = false;
  bool _isLogin = false;
  bool _isSignOut = false;
  bool _isEmailNotMatch = false;
  bool _isGetPic = true;

  UserModel? get userProfile => _userProfile;
  bool get isSignup => _isSignup;
  bool get isLogin => _isLogin;
  bool get isSignOut => _isSignOut;
  bool get isEmailNotMatch => _isEmailNotMatch;
  bool get isGetPic => _isGetPic;

   Future<void> registration(String name, String emailAddress, String password, context) async {
    _isSignup = true;
    notifyListeners();
    try {
      final credential = await auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Registration Successful');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
        _isSignup = false;
        notifyListeners();

        userAdd(emailAddress, name: name, photoUrl: '');

        // Local DB
        final userInfo = '{name: $name, email: $emailAddress}';
        DbHelper.saveData(DbTable.userInfo,DbTable.userInfo, userInfo);

      }

    } on FirebaseAuthException catch (e) {
      _isSignup = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        e.code;
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
    }
  }
  
  
  final TextEditingController _pinPutController = TextEditingController();
  Future<void> registrationWithPhone(String phnNumber,BuildContext context)async{
     print(phnNumber);
    await auth.verifyPhoneNumber(
      phoneNumber: '+8801845163069',
      // '+8801779504864', '01845163069'
      verificationCompleted: (PhoneAuthCredential credential) {
        print('Successful..................');
        print('Successful..................');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Failed.................');
      },
      codeSent: (String verificationId, int? resendToken)async{
        print('Sent..................');
        print('id............${verificationId.toString().trim()}................Id');
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: _pinPutController,
                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                      length: 6,
                      autofocus: true,
                      focusedPinTheme: PinTheme(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.red),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),

                    ),
                    SizedBox(height: 20),
                    CustomBtn(
                      onPressed: ()async{
                        print(_pinPutController.text.trim());
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: _pinPutController.text.trim());

                        // Sign the user in (or link) with the credential
                       await auth.signInWithCredential(credential);
                        //SmsAutoFill().unregisterListener();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        _pinPutController.clear();
                      },
                      text: 'Send',
                    ),
                  ],
                ),
              ),
            );
          },
        );
        //PhoneAuthProvider.credential(verificationId: verificationId, smsCode: auth.s);
      },
      timeout: Duration(minutes: 1),
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print('TimeOut...................');
      },
    );

  }


  Future<void> login(String emailAddress, String password, context) async {
     _isLogin = true;
     notifyListeners();

    try {
      final userCredential = await auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      getUserProfile();

      if (userCredential.user!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Login Successful');

        // Local Db
        final userInfo = '{email: $emailAddress}';
        DbHelper.saveData(DbTable.userInfo, DbTable.userInfo, userInfo);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
        _isLogin = false;
        notifyListeners();

      }

    } on FirebaseAuthException catch (e) {
      _isLogin = false;
      notifyListeners();
      _isEmailNotMatch = true;
      notifyListeners();
      if (e.code == 'user-not-found') {
        _isLogin = false;
        notifyListeners();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }



  Future<void> singOut(BuildContext context)async{
     _isSignOut = true;
     notifyListeners();
     try {
       await auth.signOut().then((value) {
         _isSignOut = false;
         notifyListeners();
         Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
         DbHelper.deleteData(DbTable.userInfo);

       });
     } catch (e) {
       print('Error:...............$e..................');
     }
  }


  Future<void> getUserProfile()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference user = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);


       if(currentUser?.uid != null){
         user.doc(currentUser!.email).get().then((value){
           final data = value.data() as Map<String,dynamic>;
           nameCTRL = TextEditingController(text: data['name']);
           _userProfile = UserModel(
               name: data['name'],
               email: data['email'],
               photoUrl: data['photoUrl']
           );
           notifyListeners();
         });
       }




  }


  Future<void> pickProfilePic()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    final file = await _imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 40);

    if(file != null){
      _isGetPic = false;
      notifyListeners();
      Reference reference = FirebaseStorage.instance.ref(FirebaseTable.userProfile).child('${currentUser!.email!}.jpg');
      await reference.putFile(File(file.path));
      final picUrl = await reference.getDownloadURL();
      userUpdate(currentUser.email!, photoUrl: picUrl);
      _isGetPic = true;
      notifyListeners();
    }
    _isGetPic = true;
    notifyListeners();
  }


  Future<void> ruffUse()async{
    final fireStore = FirebaseFirestore.instance;
    CollectionReference user = FirebaseFirestore.instance.collection('UserData');

    print(user.id);

    // user.doc('5cC6sCqeiXoZre4Y2qjC')
    //     .update({'edd': 'Sailful'}).then((value) {
    //   print("User Updated");
    // }).catchError((error) {
    //   print("Failed to update user: $error");
    // });

    //
    // FirebaseFirestore.instance
    //     .collection('UserData')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print('........................${doc.data()}............................');
    //   });
    // });

    await user.doc('mustakim').set({
      'email': "mustamim@mail.com"
    });


    // user.add({
    //   'emai': 'naem',
    //   'edd':  'sdfd'
    // });
  }

  Future<void> userAdd(String user,{String? name,String? photoUrl})async{
    CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

    await userCollection.doc(user).set(
      {
        'name': name,
        'email': user,
        'photoUrl': photoUrl
      }
    );

    getUserProfile();

  }

  Future<void> userUpdate(String user,{String? name,String? photoUrl})async{
    CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

    if(name != null){
      await userCollection.doc(user).update(
          {
            'name': name
          }
      );

    }else if(photoUrl != null){
      await userCollection.doc(user).update(
          {
            'photoUrl': photoUrl
          }
      );

      getUserProfile();
    }

  }


}