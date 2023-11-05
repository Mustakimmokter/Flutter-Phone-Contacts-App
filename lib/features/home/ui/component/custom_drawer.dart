import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/services/user_profile/user_profile.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.grey,
      ),
      splashRadius: 25,
    );
  }
}

class CustomDrawerBody extends StatelessWidget {
  const CustomDrawerBody({
    Key? key,
    required this.myProfileTap,
    required this.createTap,
    required this.aboutTap,
    required this.settingsTap,
    required this.logoutTap,
    required this.name,
    required this.number,
    required this.photoUrl,
  }) : super(key: key);

  final VoidCallback myProfileTap, createTap, aboutTap, settingsTap, logoutTap;
  final String name, number;
  final dynamic photoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
          padding: EdgeInsets.only(top: SizeUtils.getProportionateScreenHeight(55)),
          height: SizeUtils.screenHeight / 2.8,
          width: double.maxFinite,
          color: brandSecondaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileContainer(
                margin: const EdgeInsets.only(left: 35, top: 35),
                containerSize: 110,
                iconBorderColor: Colors.transparent,
                iconColor: Colors.transparent,
                decorationImage: UserProfile.decorationImage(photoUrl),
              ),
              const SizedBox(height: 16),
              CustomText(
                  text: name,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white),
              const SizedBox(height: 05),
              CustomText(text: number, textColor: Colors.white, fontSize: 12),
            ],
          ),
        ),
        const Spacer(flex: 1),
        IconRowTextBtn(
          icon: Icons.person_outline,
          title: 'My profile',
          onTap: myProfileTap,
        ),
        const Spacer(flex: 1),
        IconRowTextBtn(
          icon: Icons.add_circle_outline,
          title: 'Create',
          onTap: createTap,
        ),
        const Spacer(flex: 1),
        IconRowTextBtn(
          icon: Icons.info_outline,
          title: 'About',
          onTap: aboutTap,
        ),
        const Spacer(flex: 10),
        IconRowTextBtn(
          icon: Icons.lock_outline,
          title: 'Logout',
          onTap: logoutTap,
        ),
        const Spacer(flex: 5),
      ],
    );
  }
}
