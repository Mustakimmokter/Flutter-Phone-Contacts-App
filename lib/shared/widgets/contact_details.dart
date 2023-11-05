import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/index.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails(
      {Key? key,
      required this.name,
      required this.number,
      required this.avatar,
        required this.avatarOnTap,
        required this.collapsePressed,
        required this.call,
        required this.onLongPress,
        required this.favorite,
        required this.isFavorite,
      })
      : super(key: key);

  final String name, number, avatar;
  final VoidCallback avatarOnTap, collapsePressed,call, onLongPress, favorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: avatarOnTap,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: brandColor,
                  child: _text(avatar,color: Colors.white),
                ),
              ),
              const SizedBox(width: 14),
              // info
              GestureDetector(
                onTap: collapsePressed,
                onLongPress: onLongPress,
                child: Container(
                  color: Colors.transparent,
                  width: SizeUtils.screenWidth / 2.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _text(name,size: 16),
                      _text(number,size: 14,fontWeight: FontWeight.normal),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: favorite,
            child: Icon(isFavorite ? Icons.favorite_rounded: Icons.favorite_border_rounded,color: brandColor,size: 20,),
          ),
          // Call /
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: call,
            splashRadius: 20,
            icon: const Icon(Icons.call,color: brandColor,),
          ),
        ],
      ),
    );
  }

  Widget _text(String text,{Color? color,double? size,FontWeight? fontWeight}){
    return Text(
      text,
      style: TextStyle(
        color: color?? Colors.black87,
        fontSize: size ?? 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

