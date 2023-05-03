import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class ContainerAndCheckBox extends StatelessWidget {
  const ContainerAndCheckBox({
    Key? key,
    required this.isCheck,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  final bool isCheck;
  final Function(bool?) onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChanged(isCheck);
      },
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        radius: 05,
        color: Colors.transparent,
        borderColor: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: title),
            Checkbox(
              value: isCheck,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
