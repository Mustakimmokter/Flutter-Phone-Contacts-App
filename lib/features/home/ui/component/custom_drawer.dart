
import 'package:flutter/material.dart';
import 'package:phone_contact_app/app/ruff_use.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CustomContainer(
        height: 270,
        width: double.maxFinite,
        color: brandSecondaryColor,
        radius: 0,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              authService.isGetPic ? ProfileContainer(
                margin: const EdgeInsets.only(left: 35, top: 35),
                containerSize: 110,
                iconBorderColor: Colors.transparent,
                iconColor:  authService.userProfile?.photoUrl != null && authService.userProfile!.photoUrl!.isNotEmpty ?  Colors.transparent : Colors.white,
                decorationImage: authService.userProfile?.photoUrl != null && authService.userProfile!.photoUrl!.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage( authService.userProfile!.photoUrl!),
                  fit: BoxFit.cover,
                )
                    : null,
                onTap: () {
                  authService.pickProfilePic();
                },
                iconTap: () {
                  authService.pickProfilePic();
                },
              ): const
              ProfileContainer(
                containerSize: 110,
                iconSize: 0,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 16),
              CustomText(text: authService.userProfile?.name ??  'No name',fontSize: 18,fontWeight: FontWeight.w500,textColor: Colors.white),
              const SizedBox(height: 05),
              CustomText(text: authService.userProfile?.email ?? '',textColor: Colors.white,fontSize: 12),
            ],
          ),
        ),
      ),
        const SizedBox(height: 20),
        Stack(
          children: [
            IconRowTextBtn(
              iconData: Icons.person_outline,
              title: 'My profile',
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/myProfile', (route) => false);
              },
            ),
            IconRowTextBtn(
              top: 60,
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                navbarProvider.getSelectedIndex(1);
              },
            ),
            IconRowTextBtn(
              top: 100,
              iconData: Icons.add_circle_outline,
              title: 'Create',
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                navbarProvider.getSelectedIndex(2);
              },
            ),
            IconRowTextBtn(
              top: 140,
              iconData: Icons.info_outline,
              title: 'About',
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>RuffUses()), (route) => false);
              },
            ),
            IconRowTextBtn(
              top: 180,
              iconData: Icons.settings_outlined,
              title: 'Settings',
              onTap: (){
                //authService.getProfile();
                //authService.userUpdate('Rayhan',name: 'Rayhan');
                authService.getUserProfile();
              },
            ),
            IconRowTextBtn(
              top: SizeUtils.getProportionateScreenHeight(320),
              iconData: Icons.lock_outline,
              title: 'Logout',
              onTap: (){
               authService.singOut(context);
               userService.disposeData();
              },
            ),
          ],
        ),
      ],
    );
  }
}
