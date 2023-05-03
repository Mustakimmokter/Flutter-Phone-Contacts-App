import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class IconAndTextBtn extends StatelessWidget {
  const IconAndTextBtn(
      {Key? key,
      required this.onTap,
      this.label,
      this.icon,
      this.color = brandColor,
        this.iconSize = 30,
        this.labelSize = 14
      })
      : super(key: key);

  final VoidCallback onTap;
  final String? label;
  final IconData? icon;
  final Color? color;
  final double? iconSize,labelSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: iconSize,
          ),
          SizedBox(width: 04),
          CustomText(
            text: label ?? 'null',
            textColor: color,
            fontSize: labelSize,
          ),
        ],
      ),
    );
  }
}
