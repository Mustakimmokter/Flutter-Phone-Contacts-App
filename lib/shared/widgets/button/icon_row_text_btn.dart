import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class IconRowTextBtn extends StatelessWidget {
  const IconRowTextBtn({
    Key? key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20,top: 3,bottom: 3),
        width: SizeUtils.screenHeight / 5,
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon ?? Icons.star_outline,
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
