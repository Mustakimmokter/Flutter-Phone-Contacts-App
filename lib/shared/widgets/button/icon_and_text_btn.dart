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
        this.iconSize = 24,
        this.labelSize = 14,
        this.labelColor = brandColor,
        this.labelFontWeight,
        this.onLongPressed,
      })
      : super(key: key);

  final VoidCallback? onTap, onLongPressed;
  final String? label;
  final IconData? icon;
  final Color? color, labelColor;
  final double? iconSize,labelSize;
  final FontWeight? labelFontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: iconSize,
          ),
          const SizedBox(width: 04),
          Text(
            label ?? 'null',
            style: TextStyle(
              color: labelColor,
              fontSize: labelSize,
              fontWeight: labelFontWeight ?? FontWeight.normal
            ),
          ),
        ],
      ),
    );
  }
}
