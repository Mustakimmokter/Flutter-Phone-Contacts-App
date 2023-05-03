import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class IconRowTextBtn extends StatelessWidget {
  const IconRowTextBtn({
    Key? key,
    this.title,
    this.iconData,
    this.onTap,
    this.margin,
    this.left = 20,
    this.top = 20,
  }) : super(key: key);

  final String? title;
  final IconData? iconData;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final double? left, top;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        margin: margin ?? EdgeInsets.only(left: left!, top: top!),
        width: 170,
        color: Colors.transparent,
        radius: 0,
        child: Row(
          children: [
            Icon(
              iconData ?? Icons.star_outline,
              color: brandSecondaryColor,
            ),
            const SizedBox(width: 20),
            CustomText(
              text: title ?? 'Favorite',
              textColor: brandSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
