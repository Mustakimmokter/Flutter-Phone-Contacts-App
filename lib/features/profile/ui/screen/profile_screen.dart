import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameCTRL = TextEditingController(text: 'Mustakim Mokter');
  final TextEditingController emailCTRL = TextEditingController(text: 'mustakimmokter@gmail.com');
  final TextEditingController passwordCTRL = TextEditingController(text: '123456789012');

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    String image = 'assets/images/image_1.jpg';
    final profileProvider = Provider.of<ProfileProvider>(context);
    final File img ;
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
                  Navigator.pop(context);
                  profileProvider.getShowPassword(true);
                },
              ),
            ),
            CustomContainer(
              margin:
              EdgeInsets.only(top: 100, left: SizeUtils.screenWidth / 3),
              height: 130,
              width: 130,
              alignment: Alignment.center,
              color: brandColor,
              borderColor: Colors.grey.shade50,
              borderWidth: 02,
              decorationImage: profileProvider.image != null ?
              DecorationImage(
                image: FileImage(File(profileProvider.image!)),
                fit: BoxFit.cover,
              ) : null,
              child: profileProvider.image != null
                  ? const SizedBox()
                  : const CustomTextOne(
                text: 'M',
                textColor: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              child: CustomContainer(
                margin: EdgeInsets.only(left: SizeUtils.screenWidth / 1.7,top: 200),
                padding: EdgeInsets.all(05),
                color: Colors.grey.shade50,
                child: Icon(Icons.camera_alt,color: brandSecondaryColor,),
              ),
              onTap: (){
                profileProvider.getPickImage();
              },
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
