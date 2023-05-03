import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
MyProfileScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    String image = 'assets/images/image_1.jpg';
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SizedBox(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        child: Stack(
          children: [
            const CustomContainer(
              height: 180,
              radius: 0,
              color: brandSecondaryColor,
            ),
            Positioned(
              top: 60,
              left: 10,
              child: CustomBackBtn(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  profileProvider.getShowPassword(true);
                },
              ),
            ),
            Positioned(
              top: SizeUtils.getProportionateScreenHeight(125),
              left: SizeUtils.getProportionateScreenWidth(123),
              child: authService.isGetPic ? ProfileContainer(
                margin: const EdgeInsets.only(top: 95,left: 90),
                padding: const EdgeInsets.all(05),
                iconBorderColor: Colors.grey.shade50,
                containerSize: 130,
                iconSize: 30,
                decorationImage:  authService.userProfile!.photoUrl != null && authService.userProfile!.photoUrl!.isNotEmpty ?
                DecorationImage(
                  image: NetworkImage( authService.userProfile!.photoUrl!),
                  fit: BoxFit.cover,
                ) : null,
                iconTap: (){
                  authService.pickProfilePic();
                },
              ) : const
              ProfileContainer(
                containerSize: 110,
                iconSize: 0,
                child: CircularProgressIndicator(),
              ),
            ),
            _textFieldContainer(
              authService.nameCTRL!,
                Icons.person_outline,
                iconSize: 21,
                fontSize: 15,
            ),

            _textFieldContainer(
              authService.emailCTRL,
              Icons.email_outlined,
              top: 355,
              iconSize: 18,
              fontSize: 15,
            ),


            _textFieldContainer(
                authService.passwordCTRL,
              Icons.lock_outline,
              top: 430,
              obSecure: profileProvider.isShowPassword,
              onTap: (){
                profileProvider.getShowPassword(false);
              },
              onSubmit: (passW){
                profileProvider.getShowPassword(true);
              }
            ),
            Positioned(
              top: 620,
              left: 20,
              right: 20,
              child: CustomBtn(
                backgroundColor: brandSecondaryColor,
                height: 50,
                text: 'Save Changed',
                onPressed: () {
                  profileProvider.getShowPassword(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldContainer(TextEditingController controller, IconData iconData,
      {double? top,
      double? left,
      double? right,
      double? iconSize,
      double? fontSize,
        Function(String)? onChanged,
        Function(String)? onSubmit,
        bool obSecure = false,
        VoidCallback? onTap,
      }) {
    return CustomContainer(
      margin: EdgeInsets.only(
          top: top ?? 280, left: left ?? 20, right: right ?? 20),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 55,
      radius: 10,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey.shade200,
          offset: Offset(1, 1),
        )
      ],
      child: Row(
        children: [
          Icon(iconData,color: brandSecondaryColor,),
          Expanded(
            child: CustomTextField(
              controller: controller,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              onChanged: onChanged,
              onSubmit: onSubmit,
              obscureText: obSecure,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
