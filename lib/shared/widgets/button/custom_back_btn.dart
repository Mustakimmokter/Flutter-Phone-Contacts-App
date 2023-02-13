import 'package:flutter/material.dart';

class CustomBackBtn extends StatelessWidget {
  const CustomBackBtn({
    super.key,
    required this.onTap,
    this.icon = Icons.arrow_back,
    this.iconColor = Colors.white,
  });
  final VoidCallback onTap;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon,size: 30,color: iconColor,),
    );
  }
}