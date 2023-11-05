
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/search_bar/ui/component/search_build.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:provider/provider.dart';



class DataSearch extends SearchDelegate<String> {

  final CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);

  dynamic _contactList = [];
  late UserService userService;


  @override
  List<Widget>? buildActions(BuildContext context) {
    final contactInfo = infoCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
    userService = Provider.of<UserService>(context,listen: false);
    return [
      FutureBuilder(
        future: contactInfo.get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            _contactList = snapshot.data!.docs;
            return  IconButton(
              onPressed: () {
                query = '';
              },
              icon: const Icon(Icons.close),
            );
          }else{
            _contactList = [];
            return  IconButton(
              onPressed: () {
                query = '';
              },
              icon: const Icon(Icons.close),
            );
          }
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey.shade50,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
          elevation: 0,
          toolbarHeight: 65,
          shadowColor: Colors.grey.shade50,
          toolbarTextStyle: theme.textTheme.bodyMedium,
          titleTextStyle: theme.textTheme.headlineMedium),
      backgroundColor: Colors.blueGrey.shade50,
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            hintStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            border: InputBorder.none,
          ),
    );
  }

  @override
  TextStyle? get searchFieldStyle {
    return const TextStyle(fontWeight: FontWeight.normal);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matches = [];

    for(dynamic contactInfo in _contactList){
      if(contactInfo['name'].toLowerCase().contains(query.toLowerCase())){
        matches.add(contactInfo);
      }
    }

    return SearchBuild(matches: matches);
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matches = [];

    for(dynamic contactInfo in _contactList){
      if(contactInfo['name'].toLowerCase().contains(query.toLowerCase())){
        matches.add(contactInfo);
      }
    }

    return SearchBuild(matches: matches);
  }


  @override
  Widget showResults(BuildContext context) {
    super.showResults(context);
    List<dynamic> matches = [];

    for(dynamic contactInfo in _contactList){
      if(contactInfo['name'].toLowerCase().contains(query.toLowerCase())){
        matches.add(contactInfo);
      }
    }

    return SearchBuild(matches: matches);
  }

}
