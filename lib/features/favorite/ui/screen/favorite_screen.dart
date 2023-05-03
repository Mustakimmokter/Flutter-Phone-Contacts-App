import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/favorite/provider/favorite_provider.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:phone_contact_app/shared/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        child:  Column(
          children: [
            SafeArea(
              child: CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.grey.shade200,
                radius: 0,
                height: 55,
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Favorite',textColor: Colors.grey,),
                    IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: DataSearch(
                              contactList: favoriteProvider.contactList
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
              child: ListView.builder(
                itemCount: favoriteProvider.contactList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: AnimatedContainer(
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
                      //height: favoriteProvider.contactList[index].isSelected ? 120: null,
                      child: Column(
                        children: [
                          ContactDetails(
                            iconData: Icons.call,
                            secondBtnIcon: Icons.favorite,
                            color: brandSecondaryColor,
                            name: favoriteProvider.contactList[index].name!,
                            number: favoriteProvider.contactList[index].number!,
                            avatar: favoriteProvider.contactList[index].avatar!,
                            onTapOne: () {
                             Navigator.pushNamed(context, '/detailsScreen');
                            },
                            onTapTwo: (){
                              favoriteProvider.getIsTrue(index);
                            },
                            call: (){
                            },
                            secondBtn: (){
                              showDialog(context: context, builder: (context) {
                                return const CustomDialogBox(
                                  description: 'Are you sure to remove the favorite?',
                                );
                              },);
                            },
                          ),
                          if(favoriteProvider.contactList[index].isSelected)
                          const Divider(),
                          if(favoriteProvider.contactList[index].isSelected)
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconAndTextBtn(
                                    onTap: (){},
                                    icon: Icons.message,
                                    iconSize: 20,
                                    label: 'Message',
                                    labelSize: 12,
                                  ),
                                  const VerticalDivider(),
                                  IconAndTextBtn(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/detailsScreen');
                                    },
                                    icon: Icons.person,
                                    iconSize: 20,
                                    label: 'Details',
                                    labelSize: 12,
                                  ),
                                  const VerticalDivider(),
                                  IconAndTextBtn(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CustomDialogBox(
                                            description: 'Are you sure to remove the contact?',
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.delete,
                                    iconSize: 20,
                                    label: 'Delete',
                                    labelSize: 12,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


