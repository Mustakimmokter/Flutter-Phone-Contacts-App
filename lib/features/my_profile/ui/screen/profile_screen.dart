import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:phone_contact_app/shared/navbar_controller/nav_bar_controller.dart';
import 'package:phone_contact_app/shared/services/user_profile/user_profile.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class UserState extends StatelessWidget {
   UserState({super.key, required this.number});

   final String number;

  final CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);

  @override
  Widget build(BuildContext context) {
    final getUser = userCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber);
    return FutureBuilder(
      future: getUser.get(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data!.exists){
          return const NavBarController();
        }else{
          return MyProfileScreen(number: number);
        }
    },);
  }
}


class MyProfileScreen extends StatelessWidget {
 MyProfileScreen({Key? key, required this.number,}) : super(key: key);
 final String number;

 final CollectionReference userCollection = FirebaseFirestore.instance.collection(FirebaseTable.userProfile);



  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    SizeUtils().init(context);
    final getUser = userCollection.doc(FirebaseAuth.instance.currentUser!.phoneNumber);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SizedBox(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        child: FutureBuilder(
          future: getUser.get(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final userProfile = snapshot.data!;
              dynamic noData = {'photoUrl':''};
              //profileProvider.getNameValue(userProfile['name'].toString());
              return Stack(
                children: [
                  const CustomContainer(
                    height: 180,
                    radius: 0,
                    color: brandSecondaryColor,
                  ),
                  // Profile image and button
                  Positioned(
                    top: SizeUtils.getProportionateScreenHeight(125),
                    left: SizeUtils.getProportionateScreenWidth(123),
                    child: profileProvider.isProfilePicDone ? ProfileContainer(
                      containerSize: 120,
                      margin: const EdgeInsets.only(top: 90,left: 80),
                      iconSize: 20,
                      padding: const EdgeInsets.all(5),
                      iconColor: Colors.grey,
                      iconData: Icons.camera_alt,
                      iconTap: (){
                        profileProvider.getCameraOrGallery(true);
                      },
                      decorationImage: UserProfile.decorationImage(userProfile.exists ? userProfile: noData, profileProvider.image),
                    ):
                    const ProfileContainer(
                      containerSize: 120,
                      margin: EdgeInsets.only(top: 90,left: 80),
                      iconSize: 0,
                      padding: EdgeInsets.all(5),
                      iconBorderColor: Colors.transparent,
                      iconColor: Colors.transparent,
                      iconData: Icons.camera_alt,
                      child: Center(child: CircularProgressIndicator(),),
                    ),
                  ),
                  CustomContainer(
                    margin: const EdgeInsets.only(
                        top: 280, left:20, right: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.centerLeft,
                    height: 55,
                    radius: 10,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.shade200,
                        offset: const Offset(1, 1),
                      )
                    ],
                    child: CustomTextField(
                      controller: profileProvider.nameController,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      hintText: 'Enter your name',
                      onSubmit: (newValue){
                        profileProvider.getCameraOrGallery(false);
                      },
                      onChanged: (newName){
                        profileProvider.getCameraOrGallery(false);
                      },
                    ),
                  ),
                  // Number Field
                  GestureDetector(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const CustomSnackBar(title: 'No editable',icon: Icons.edit_off_rounded).snackBar()
                      );
                    },
                    child: CustomContainer(
                      margin: const EdgeInsets.only(
                          top: 350, left:20, right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.centerLeft,
                      height: 55,
                      radius: 10,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.shade200,
                          offset: const Offset(1, 1),
                        )
                      ],
                      child: CustomText(text: authService.userNumber),
                    ),
                  ),

                  // Save & Continue
                  Positioned(
                    top: 520,
                    left: 20,
                    right: 20,
                    child: CustomBtn(
                      backgroundColor: brandSecondaryColor,
                      text: 'Save & Continue',
                      child: Row(
                        children: [
                          const Spacer(flex: 6,),
                          const CustomText(text: 'Save & Continue',textColor: Colors.white,),
                          const Spacer(flex: 3,),
                          CircularProgressIndicator(color: userService.isUpdateProfile ? Colors.white : Colors.transparent,),
                          const Spacer(flex: 1),
                        ],
                      ),
                      onPressed: () {
                        profileProvider.upLoadProfilePic(profileProvider.image);
                        userService.saveUserProfile(profileProvider.nameController.text,context);
                        Fluttertoast.showToast(msg: 'Save changed');
                      },
                    ),
                  ),

                  // Photo selected
                  Positioned(
                    right: SizeUtils.screenWidth / 10,
                    top: SizeUtils.screenHeight / 3.2,
                    child: profileProvider.isCameraAndGallery? Row(
                      children: List.generate(3, (index) {
                        final List<IconData> icons = [
                          Icons.camera,
                          Icons.photo_library,
                          Icons.close,
                        ];
                        final List<VoidCallback> onTaps = [
                              (){
                            profileProvider.getPickImage('camera');
                          },
                              (){
                            profileProvider.getPickImage('gallery');
                          },
                              (){
                            profileProvider.getCameraOrGallery(false);
                          },
                        ];
                        return GestureDetector(
                          onTap: onTaps[index],
                          child: CustomContainer(
                            margin: const EdgeInsets.only(left: 5),
                            height: 40,
                            width: 40,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 10,
                                  offset: const Offset(1, 1)
                              ),
                            ],
                            color: Colors.white,
                            child: Icon(icons[index],color: Colors.grey,),
                          ),
                        );
                      }),
                    ):const SizedBox(),
                  ),


                ],
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
