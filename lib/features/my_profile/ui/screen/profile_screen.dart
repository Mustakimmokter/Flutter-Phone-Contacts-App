import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
MyProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameCTRL = TextEditingController(text: 'Mustakim Mokter');
  final TextEditingController emailCTRL = TextEditingController(text: 'mustakimmokter@gmail.com');
  final TextEditingController passwordCTRL = TextEditingController(text: '123456789012');

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    String image = 'assets/images/image_1.jpg';
    final profileProvider = Provider.of<ProfileProvider>(context);
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
              child: ProfileContainer(
                margin: EdgeInsets.only(top: 95,left: 90),
                padding: EdgeInsets.all(05),
                iconBorderColor: Colors.grey.shade50,
                containerSize: 130,
                iconSize: 30,
                decorationImage: profileProvider.image != null ?
                DecorationImage(
                  image: FileImage(File(profileProvider.image!)),
                  fit: BoxFit.cover,
                ) : null,
                iconTap: (){
                  profileProvider.getPickImage();
                },
              ),
            ),
            _textFieldContainer(
              nameCTRL,
                Icons.person_outline,
                iconSize: 21,
                fontSize: 15,
            ),

            _textFieldContainer(
              emailCTRL,
              Icons.email_outlined,
              top: 355,
              iconSize: 18,
              fontSize: 15,
            ),


            _textFieldContainer(
              passwordCTRL,
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
