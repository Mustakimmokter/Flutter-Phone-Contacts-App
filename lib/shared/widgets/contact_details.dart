import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails(
      {Key? key,
      required this.name,
      required this.number,
      required this.avatar,
        required this.onTapOne,
        required this.onTapTwo,
        required this.call,
        this.secondBtn,
        this.iconData,
        this.color,
        this.secondBtnIcon,
      })
      : super(key: key);

  final String name, number, avatar;
  final Function()? onTapOne, onTapTwo, secondBtn,call;
  final IconData? iconData, secondBtnIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTapOne,
                child: CustomContainer(
                  height: 45,
                  width: 45,
                  radius: 100,
                  color: color ?? brandColor,
                  alignment: Alignment.center,
                  child: CustomText(text: avatar,textColor: Colors.white,),
                ),
              ),
              const SizedBox(width: 14),
              // info
              GestureDetector(
                onTap: onTapTwo,
                child: CustomContainer(
                  radius: 0,
                  color: Colors.transparent,
                  width: SizeUtils.getProportionateScreenWidth(155),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        textOverflow: TextOverflow.ellipsis
                      ),
                      CustomText(
                        text: number,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Call /
          Row(
            children: [
                GestureDetector(
                  onTap: secondBtn,
                  child: Icon(
                    secondBtnIcon ?? Icons.arrow_drop_down,
                    color: Colors.pink,
                    size: 20,
                  ),
                ),
              const SizedBox(width: 05),
              IconButton(
                onPressed: call,
                splashRadius: 25,
                icon: Icon(
                  iconData ?? Icons.call,
                  color: color ?? brandColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

