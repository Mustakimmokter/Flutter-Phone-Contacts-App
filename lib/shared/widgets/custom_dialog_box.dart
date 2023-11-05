import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    Key? key,
    this.title = 'Please Confirm',
    this.description = 'Are you sure to remove this contact?', this.yesTap, this.noTap,
  }) : super(key: key);

  final String title, description;
  final VoidCallback? yesTap, noTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomContainer(
          height: SizeUtils.getProportionateScreenHeight(130),
          width: SizeUtils.getProportionateScreenWidth(260),
          radius: 14,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              CustomText(
                text: title,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: description,
                fontSize: 12,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 1.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: yesTap,
                      child: const CustomText(
                        text: 'Yes',
                        textColor: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const VerticalDivider(thickness: 1.5),
                    GestureDetector(
                      onTap: noTap,
                      child: const CustomText(
                        text: 'No',
                        textColor: brandColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
