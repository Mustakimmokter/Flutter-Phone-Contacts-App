import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
    this.label,
    this.icon,
    this.selectedColor = Colors.grey,
    required this.onTap,
    required this.index,
    this.size = 30,
  }) : super(key: key);

  final Function(int?) onTap;
  final String? label;
  final IconData? icon;
  final Color?  selectedColor;
  final int index;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: (){
        onTap(index);
      },
      child: CustomContainer(
        height: 65,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedColor,
              size: size,
            ),
            SizedBox(width: 04),
            CustomText(
              text: label?? 'null',
              textColor: selectedColor,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
