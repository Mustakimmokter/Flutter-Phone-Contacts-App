import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/favorite/provider/favorite_provider.dart';
import 'package:phone_contact_app/features/search_bar/ui/screen/search_bar.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteProvider>(
      create: (context) {
      return FavoriteProvider();
    },
      child: FavoriteScreenBody(),
    );
  }
}


class FavoriteScreenBody extends StatelessWidget {
  FavoriteScreenBody({Key? key}) : super(key: key);

  final CollectionReference infoCollection = FirebaseFirestore.instance.collection(FirebaseTable.contacts);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final userService = Provider.of<UserService>(context);
    final contactInfo = infoCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection(FirebaseTable.contactInfo);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey.shade200,
              radius: 0,
              height: SizeUtils.getProportionateScreenHeight(65),
              alignment: Alignment.centerLeft,
              width: double.maxFinite,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 6,),
                  const CustomText(text: 'Favorite',textColor: Colors.grey,),
                  const Spacer(flex: 4,),
                  IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: DataSearch(
                          ),
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
                          return contacts[index]['isFavorite']? AnimatedContainer(
                            padding: EdgeInsets.only(
                              top: favoriteProvider.contactList[index].isSelected ? 08: 12,
                              bottom: favoriteProvider.contactList[index].isSelected ? 08: 12,
                              right: favoriteProvider.contactList[index].isSelected ? 0: 03,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 10,
                              top: 5,
                            ),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              // color: favoriteProvider.contactList[index].isSelected ? Colors.white :
                              // Colors.grey.shade400.withOpacity(0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: favoriteProvider.contactList[index].isSelected ? Colors.grey.shade400 :
                                Colors.grey.shade400,
                              ),
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
                                    favoriteProvider.getIsTrue(index);
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
                                if(favoriteProvider.contactList[index].isSelected)
                                  const Divider(),
                                if(favoriteProvider.contactList[index].isSelected)
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        IconAndTextBtn(
                                          onTap: () {},
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
                          ):
                          const SizedBox();
                      },
                    ): const Center(child: CustomText(text: 'No data',textColor: Colors.grey,fontSize: 20,),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
        ],
      ),
    );
  }

}


