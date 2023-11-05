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

  void addAndRemoveFavorite(bool value,BuildContext context){
     value =! value;
    _isUpdateFavorite = value;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      _isUpdateFavorite ? const CustomSnackBar(title: 'Added to favorite',icon: Icons.favorite_rounded).snackBar() :
      const CustomSnackBar(icon: Icons.favorite_border_rounded, title: 'Remove to favorite').snackBar()
    );
  }

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
         //print('Try again');
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
         //print('Try again');
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
  // share
  Future<void> shareContact(String number)async{
  try{
    Share.shareWithResult(number);
  }catch(e){
    //print(e);
  }
}


  bool _isEditedDetails = false;
  bool get isEditedDetails => _isEditedDetails;

  void getEditedDetails(bool val){
    _isEditedDetails = val;
    notifyListeners();
  }

}
