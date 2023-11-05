import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';


class CustomSnackBar {

  const CustomSnackBar({
    Key? key,
    required this.title,
    this.height,
    this.icon,
    this.child,
  });
  final String title;
  final double? height;
  final IconData? icon;
  final Widget? child;

   SnackBar snackBar(){
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 1),
      content: Container(
      height: height ?? 60,
      decoration: BoxDecoration(
        color: const Color(0xff3d4287),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(3, 3),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ?? Icon(icon ?? Icons.check, color: Colors.white,size: 20,),
          const SizedBox(width: 10),
          CustomText(text: title, textColor: Colors.white),
        ],
      ),
    ),
    );
  }


}