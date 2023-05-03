import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_contact_app/features/db/table.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';

class UserService extends ChangeNotifier {

  ContactInfoModel? contactInfoModel;

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
    }
  }


  Future<void> getContacts()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);
    if(currentUser?.uid != null){
      //final contactInfo = infoCollection.doc(currentUser!.email).collection(FirebaseTable.contactInfo).doc('akram');
      final contactInfo = infoCollection.doc(currentUser!.email).collection(FirebaseTable.contactInfo);

      contactInfo.get().then((value){
        value.docs.forEach((element) {
          print(element.data());
        });
      });
    }


  }


}
