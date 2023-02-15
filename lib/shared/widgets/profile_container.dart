import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/widgets/custom_container.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    this.iconTap,
    this.onTap,
    this.containerSize = 120,
    this.iconSize = 40,
    this.iconColor = brandSecondaryColor,
    this.iconBorderColor = Colors.white,
    this.padding,
    this.margin,
    this.decorationImage,
    this.child,
    this.iconData = Icons.camera_alt,
  }) : super(key: key);

  final VoidCallback? iconTap, onTap;
  final double? containerSize,iconSize;
  final Color? iconColor,iconBorderColor;
  final EdgeInsets? padding, margin;
  final DecorationImage? decorationImage;
  final Widget? child;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: containerSize,
            width: containerSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(100),
              image: decorationImage
            ),

            child: child,
          ),
          CustomContainer(
            margin: margin,
            padding: padding,
            color: iconBorderColor,
            child: GestureDetector(
              onTap: iconTap,
              child: Icon(
                iconData,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
