import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn(
      {Key? key,
      required this.onTap,
      this.iconColor,
      this.backgroundColor,
      this.height,
      this.width,
      this.radius,
      this.iconSize,
        this.child,
        this.icon,
      })
      : super(key: key);

  final VoidCallback onTap;
  final Color? iconColor, backgroundColor;
  final double? height, width, radius, iconSize;
  final Widget? child;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        color: backgroundColor ?? brandSecondaryColor,
        height: height,
        width: width,
        radius: radius,
        child: child ?? Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
