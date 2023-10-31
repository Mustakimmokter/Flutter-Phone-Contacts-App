import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UserService extends ChangeNotifier {

   bool _isUpdateProfile = false;
  bool get isUpdateProfile => _isUpdateProfile;

  late bool _isUpdateFavorite;
  bool? get isUpdateFavorite => _isUpdateFavorite;





  Future<void> addContact(String id,{
    required String name,
    required String number,
    bool? isFavorite = false,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
    if (currentUser?.uid != null) {
     await infoCollection.doc(currentUser!.phoneNumber).collection(FirebaseTable.contactInfo).doc(id).set({
       'isFavorite': isFavorite,
       'id': id,
        'name': name,
        'number': number,
      });
    }

  }


  Future<void> deleteContact(String id,BuildContext context)async{
    Navigator.pop(context);
    notifyListeners();
    final auth = FirebaseAuth.instance;
    if(auth.currentUser?.uid != null && auth.currentUser!.uid.isNotEmpty){
      CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
      final contactInfo =  infoCollection.doc(auth.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
      await contactInfo.get().then((contacts) {
        contactInfo.doc(id).delete();
        notifyListeners();
      });
    }


  }

  Future<void> updateContact(BuildContext context,String id,{required Map<String,dynamic> updateData})async{
    final auth = FirebaseAuth.instance;
    if(auth.currentUser?.uid != null && auth.currentUser!.uid.isNotEmpty){
      CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
      final contactInfo =  infoCollection.doc(auth.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
      await contactInfo.get().then((contacts) {
        contactInfo.doc(id).update(updateData);
        notifyListeners();
      });
    }


  }

  void updateFavorite(bool value,BuildContext context){
     value =! value;
    _isUpdateFavorite = value;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      _isUpdateFavorite ? const CustomSnackBar(title: 'Added to favorite',icon: Icons.favorite_rounded).snackBar() :
      const CustomSnackBar(icon: Icons.favorite_border_rounded, title: 'Remove to favorite').snackBar()
    );
  }

   dynamic getContacts()async{
    final auth = FirebaseAuth.instance;
      CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
      //final contactInfo = infoCollection.doc(currentUser!.email).collection(FirebaseTable.contactInfo).doc('akram');
      final contactInfo = infoCollection.doc(auth.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
      // contactInfo.get().then((contacts)async{
      //    _contactInfoList = contacts.docs;
      //    notifyListeners();
      // });


    return contactInfo;

  }



  Future<void> getUserProfile()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference user = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

    try{
      if(currentUser?.uid != null){
        user.doc(currentUser!.phoneNumber).get().then((value){
          final data = value.data() as Map<String,dynamic>;
          //nameCTRL = TextEditingController(text: data['name']);
          // _userProfile = UserModel(
          //     name: data['name'],
          //     email: data['email'],
          // );
          notifyListeners();
        });
      }
    }catch (error){
      print('User not found');
    }




  }

  /* bool _isProfilePicDone = true;
   bool get isProfilePicDone => _isProfilePicDone;

  Future<void> upLoadProfilePic(String image)async{
    print('object..............1..............$_isProfilePicDone');
    _isProfilePicDone = false;
    notifyListeners();
    print('object..............2..............$_isProfilePicDone');
    final currentUser = FirebaseAuth.instance.currentUser;
    try{
      if(image.isNotEmpty){
        Reference reference = FirebaseStorage.instance.ref(FirebaseTable.userProfile).child('${currentUser!.phoneNumber}.jpg');
        await reference.putFile(File(image),);
            _isProfilePicDone = true;
            notifyListeners();
      }
    }catch(e){
      print('Try again');
    }
    print('object..............3..............$_isProfilePicDone');
  }*/

   Future<void> saveUserProfile(String? name,BuildContext context)async{
     _isUpdateProfile = true;
     notifyListeners();

    await Future.delayed(const Duration(seconds: 1),()async{
       final currentUser = FirebaseAuth.instance.currentUser;
       CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

       try{
         Reference reference = FirebaseStorage.instance.ref(FirebaseTable.userProfile).child('${currentUser!.phoneNumber}.jpg');
         final photoUrl = await reference.getDownloadURL();

         final updateName = name == null || name.isEmpty? 'NoName' : name;
         final updatePhotoUrl = photoUrl.isEmpty ? 'noPhoto' : photoUrl;

         await userCollection.doc(currentUser.phoneNumber).set({
           'number': currentUser.phoneNumber,
           'name': updateName,
           'photoUrl': updatePhotoUrl,
         });
         _isUpdateProfile = false;
         notifyListeners();
         // ignore: use_build_context_synchronously
         Navigator.pushNamedAndRemoveUntil(context, '/navBarController',(route) => false,);
       }catch(e){
         _isUpdateProfile = false;
         print('Try again');
       }
     });
    }

   Future<void> getUpdateUserProfile()async{
          final currentUser = FirebaseAuth.instance.currentUser;
       CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

       try{
         Reference reference = FirebaseStorage.instance.ref(FirebaseTable.userProfile).child('${currentUser!.phoneNumber}.jpg');
         final photoUrl = await reference.getDownloadURL();

         final updatePhotoUrl = photoUrl.isEmpty ? 'noPhoto' : photoUrl;

         await userCollection.doc(currentUser.phoneNumber).update({
           'photoUrl': updatePhotoUrl,
         });
       }catch(e){
         print('Try again');
       }
   }



 // Make Phone call
  Future<void> phoneCallDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  // Make sms
  Future<void> phoneSMS(String number)async{
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: number,
    );
    await launchUrl(smsLaunchUri);
  }

  // Make direct Phone call (Need only one sim select from your phone settings)
  // Future<void> phoneCallDirect(String phoneNumber) async{
  //  await FlutterPhoneDirectCaller.callNumber('+88$phoneNumber');
  //
  // }
Future<void> shareContact(String number)async{
  try{
    //Share.share(number,subject: 'telegram is social media');
    Share.shareWithResult(number);
  }catch(e){
    print(e);
  }
}

  /// Number Validation
/*
return RegExp(
  // "^(?:[+0]9)?[0-9]{10,12}",
  "^[0-9]{4} [0-9]{7}",
).hasMatch(name!)
    ? null
    : 'Format XXXX XXXXXXX';
*/




  bool _isEditedDetails = false;
  bool get isEditedDetails => _isEditedDetails;

  void getEditedDetails(bool val){
    _isEditedDetails = val;
    notifyListeners();
  }

}
