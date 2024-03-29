import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet(
      {Key? key,
      required this.nameCNTLR,
      required this.numberCNTLR,
      required this.title,
      required this.onPressed,
      required this.nameChanged,
      required this.numberChanged,
      this.header})
      : super(key: key);

  final TextEditingController nameCNTLR, numberCNTLR;
  final String? title, header;
  final VoidCallback? onPressed;
  final Function(String) nameChanged, numberChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 05,
          child: Column(
            children: [
              CustomText(
                text: header ?? '',
                textColor: brandSecondaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 05),
              CustomContainer(
                color: Colors.grey.shade400,
                height: 4,
                width: 70,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 60,
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                padding: const EdgeInsets.only(left: 14),
                controller: nameCNTLR,
                autofocus: true,
                onChanged: nameChanged,
                hintText: 'First name',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                padding: const EdgeInsets.only(left: 14),
                controller: numberCNTLR,
                keyBoardType: TextInputType.number,
                onChanged: numberChanged,
                hintText: 'Phone number',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          child: CustomBtn(
            backgroundColor: brandSecondaryColor,
            radius: 10,
            onPressed: onPressed,
            text: title,
          ),
        )
      ],
    );
  }
}
