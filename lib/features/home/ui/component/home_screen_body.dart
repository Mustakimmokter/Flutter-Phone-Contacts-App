import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/home/provider/body_provider.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/utils/size_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:phone_contact_app/shared/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyProvider = Provider.of<BodyProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        child: Column(
          children: [
            CustomContainer(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.only(left: 10,right: 05),
              color: Colors.grey,
              height: 50,
              alignment: Alignment.centerLeft,
              width: double.maxFinite,
              boxDecoration: BoxDecoration(
                  border:
                  Border(bottom: BorderSide(color: Colors.grey.shade200))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.grey,
                    ),
                  ),
                  const CustomTextOne(text: 'Contacts',textColor: Colors.grey,),
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(
                          contactList: bodyProvider.contactList
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
            Expanded(
              child: ListView.builder(
                itemCount: bodyProvider.contactList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                    ),
                    child: AnimatedContainer(
                      // key: Key(bodyProvider.contactList[index].name!),
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                        top: bodyProvider.contactList[index].isSelected ? 10: 0,
                        bottom: bodyProvider.contactList[index].isSelected ? 10: 0,
                      ),
                      margin: EdgeInsets.only(
                        bottom: bodyProvider.contactList[index].isSelected ? 10: 0,
                        top: bodyProvider.contactList[index].isSelected ? 05: 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: bodyProvider.contactList[index].isSelected ? Colors.grey.shade200 : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      //height: bodyProvider.contactList[index].isSelected ? 120: null,
                      child: Column(
                        children: [
                          ContactDetails(
                            avatar: bodyProvider.contactList[index].name![0],
                            name: bodyProvider.contactList[index].name!,
                            number: bodyProvider.contactList[index].number!,
                            secondBtnIcon: index.isEven? Icons.favorite_border: Icons.favorite,
                            onTapOne: () {
                              Navigator.pushNamed(context, '/detailsScreen');
                            },
                            onTapTwo: (){
                              bodyProvider.getIsTrue(index);
                            },
                            secondBtn: (){
                              const snackBar = SnackBar(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 08),
                                elevation: 0,
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.transparent,
                                content: CustomSnackBar(
                                  title: 'Added to the favorite',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            call: (){},
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: bodyProvider.contactList[index].isSelected ? 0: 10,
                              right: bodyProvider.contactList[index].isSelected ? 0: 10,
                            ),
                            child: const Divider(),
                          ),
                          if(bodyProvider.contactList[index].isSelected)
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
                                          return const CustomDialogBox();
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


/*
 Navigator.push(context, MaterialPageRoute(builder: (_)=> UpdateScreen(
                        number: SearchBar.numberList[index],
                        name: SearchBar.nameList[index],
                      )));
 */