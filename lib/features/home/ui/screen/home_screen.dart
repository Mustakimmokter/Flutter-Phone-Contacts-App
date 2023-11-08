import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/home/provider/home_provider.dart';
import 'package:phone_contact_app/features/home/ui/component/index.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/features/search_bar/ui/screen/search_bar.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/utils/size_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider(),child: HomeScreenBody(),);

  }
}


class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({Key? key}) : super(key: key);

  final CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);

  final CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final contactInfo = infoCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
    final getUser = userCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber);
    final userService = Provider.of<UserService>(context)..getUpdateUserProfile();
    return Scaffold(
      body:       Column(
        children: [
          CustomContainer(
            margin:  EdgeInsets.only(top: SizeUtils.screenHeight / 15),
            padding: const EdgeInsets.only(left: 10, right: 05),
            color: Colors.grey,
            height: SizeUtils.getProportionateScreenHeight(65),
            alignment: Alignment.centerLeft,
            width: double.maxFinite,
            boxDecoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomDrawer(),
                const CustomText(
                  text: 'Contacts', textColor: Colors.grey,),
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch(),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: contactInfo.get(),
                builder: (context, snapshotData) {
                  if (snapshotData.hasData) {
                    final List<dynamic> contacts = snapshotData.data!.docs;
                    return contacts.isNotEmpty ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                      itemCount: contacts.isEmpty ? 1 : contacts.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.only(
                            top: homeProvider.contactList[index].isSelected ? 10 : 0,
                            bottom: homeProvider.contactList[index].isSelected ? 10 : 0,
                          ),
                          margin: EdgeInsets.only(
                            bottom: homeProvider.contactList[index]
                                .isSelected ? 10 : 0,
                            top: homeProvider.contactList[index]
                                .isSelected ? 05 : 0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: homeProvider.contactList[index]
                                  .isSelected
                                  ? Colors.grey.shade200
                                  : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Column(
                            children: [
                              ContactDetails(
                                avatar: contacts[index]['name'][0],
                                name: contacts[index]['name'],
                                number: contacts[index]['number'],
                                isFavorite: contacts[index]['isFavorite'],
                                // LongPress Button
                                onLongPress: (){
                                  userService.shareContact(contacts[index]['number']);
                                },
                                avatarOnTap: () {
                                  final params = {
                                    'name': contacts[index]['name'],
                                    'number':contacts[index]['number'],
                                    'id': contacts[index]['id']
                                  };
                                  Navigator.pushNamed(context, '/detailsScreen',arguments: params);
                                },
                                // Collapse Button
                                collapsePressed: () {
                                  homeProvider.isCollapse(index);
                                },
                                // Favorite Button
                                favorite: (){
                                  userService.addAndRemoveFavorite(contacts[index]['isFavorite'],context);
                                  final updateData = {'isFavorite': userService.isUpdateFavorite};
                                  userService.updateContact(context, contacts[index]['id'], updateData: updateData);
                                },
                                // Call Button
                                call: () {
                                  userService.phoneCallDialer(contacts[index]['number']);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: homeProvider
                                      .contactList[index].isSelected
                                      ? 0
                                      : 10,
                                  right: homeProvider
                                      .contactList[index].isSelected
                                      ? 0
                                      : 10,
                                ),
                                child: const Divider(),
                              ),
                              if(homeProvider.contactList[index]
                                  .isSelected)
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      IconAndTextBtn(
                                        onTap: () {
                                          userService.phoneSMS(contacts[index]['number']);
                                        },
                                        icon: Icons.message,
                                        iconSize: 20,
                                        label: 'Message',
                                        labelSize: 12,
                                      ),
                                      const VerticalDivider(),
                                      IconAndTextBtn(
                                        onTap: () {
                                          final params = {
                                            'name': contacts[index]['name'],
                                            'number':contacts[index]['number'],
                                            'id': contacts[index]['id'],
                                          };
                                          Navigator.pushNamed(context, '/detailsScreen',arguments: params);
                                        },
                                        icon: Icons.person,
                                        iconSize: 20,
                                        label: 'Details',
                                        labelSize: 12,
                                      ),
                                      const VerticalDivider(),
                                      SizedBox(
                                        child:  IconAndTextBtn(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (
                                                  BuildContext context) {
                                                return CustomDialogBox(
                                                  yesTap: () {
                                                    userService.deleteContact(contacts[index]['id'], context);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const CustomSnackBar(title: 'Delete successful').snackBar(),
                                                    );

                                                  },
                                                  noTap: () {
                                                    Navigator.pop(context);

                                                  },

                                                );
                                              },
                                            );
                                          },
                                          icon: Icons.delete,
                                          iconSize: 20,
                                          label: 'Delete',
                                          labelSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ): const Center(child: CustomText(text: 'No data',textColor: Colors.grey,fontSize: 20,));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
        ],),
      drawer: CustomContainer(
        radius: 0,
        color: Colors.white,
        width: SizeUtils.screenWidth / 1.5,
        child: FutureBuilder(
          future: getUser.get(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final userProfile = snapshot.data!;
              dynamic noData = {'photoUrl':''};
              return CustomDrawerBody(
                name: userProfile.exists ? userProfile['name'].toString() : 'No name',
                number: authService.userNumber,
                photoUrl: userProfile.exists ? userProfile: noData,
                myProfileTap: () {
                  final name = userProfile.exists ? userProfile['name'].toString() : '';
                  profileProvider.getNameValue(name.toString());
                  final params = {'number': ''};
                  Navigator.pushNamed(context, '/myProfile',arguments: params);
                  profileProvider.imageDispose();
                  profileProvider.getProfilePicDone(true);
                },
                createTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/createScreen',);
                },
                aboutTap: () {  },
                settingsTap: () {  },
                logoutTap: () {
                  authService.singOut(context);
                },
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
