import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    Key? key,
    required this.title,
    this.height,
    this.icon,
  }) : super(key: key);

  final String title;
  final double? height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: height ?? 70,
      radius: 10,
      color: const Color(0xff3d4287),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(3, 3),
          blurRadius: 6,
        ),
      ],
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.check, color: Colors.white),
          const SizedBox(width: 10),
          CustomText(text: title, textColor: Colors.white),
        ],
      ),
    );
  }
}
