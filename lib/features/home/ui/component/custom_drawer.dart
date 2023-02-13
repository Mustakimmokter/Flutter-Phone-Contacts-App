import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/home/ui/screen/home_screen.dart';
import 'package:phone_contact_app/features/login/ui/screen/login_screen.dart';
import 'package:phone_contact_app/features/profile/ui/screen/profile_screen.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    String image = 'assets/images/image_1.jpg';
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
              CustomContainer(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                color: Colors.grey.shade400,
                borderWidth: 02,
                decorationImage: DecorationImage(image: AssetImage(image)),
                child: image.isNotEmpty? const SizedBox() : const Icon(Icons.camera_alt,color: Colors.white,size: 40,),
              ),
              const SizedBox(height: 16),
              const CustomTextOne(text: 'Mustakim Mokter',fontSize: 18,fontWeight: FontWeight.w500,textColor: Colors.white),
              const SizedBox(height: 05),
              const CustomTextOne(text: '01779-504864',textColor: Colors.white),
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
            ),
            IconRowTextBtn(
              top: 60,
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreen()), (route) => false);
                navbarProvider.getSelectedIndex(1);
              },
            ),
            IconRowTextBtn(
              top: 100,
              iconData: Icons.add_circle_outline,
              title: 'Create',
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
                navbarProvider.getSelectedIndex(2);
              },
            ),
            IconRowTextBtn(
              top: 140,
              iconData: Icons.info_outline,
              title: 'About',
              onTap: (){},
            ),
            IconRowTextBtn(
              top: 180,
              iconData: Icons.settings_outlined,
              title: 'Settings',
              onTap: (){},
            ),
            IconRowTextBtn(
              top: SizeUtils.getProportionateScreenHeight(320),
              iconData: Icons.lock_outline,
              title: 'Logout',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
