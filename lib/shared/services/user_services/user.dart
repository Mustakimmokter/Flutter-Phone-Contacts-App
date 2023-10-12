import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_contact_app/features/db/table.dart';

class UserService extends ChangeNotifier {

  List<dynamic>? contactInfoList;



  List<dynamic> dat = [];

  Future<void> addContact({
    required String name,
    required String avatar,
    required String number,
    bool? isFavorite = false,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference infoCollection =
        FirebaseFirestore.instance.collection(FirebaseTable.contacts);
    if (currentUser?.uid != null) {
      infoCollection.doc(currentUser!.email).collection(FirebaseTable.contactInfo).doc(name).set({
        'isFavorite': isFavorite,
        'name': name,
        'number': number,
        'avatar': avatar
      });
      getContacts();
    }
  }


  Future<void> getContacts()async {
    final auth = FirebaseAuth.instance;
    if(auth.currentUser?.uid != null && auth.currentUser!.uid.isNotEmpty){
      CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
      //final contactInfo = infoCollection.doc(currentUser!.email).collection(FirebaseTable.contactInfo).doc('akram');
      final contactInfo = infoCollection.doc(auth.currentUser!.email).collection(FirebaseTable.contactInfo);

      contactInfo.get().then((contactValues){
       contactInfoList = contactValues.docs;
       notifyListeners();

      });

    }


  }


  void disposeData(){
    contactInfoList = [];
    notifyListeners();
  }




}
