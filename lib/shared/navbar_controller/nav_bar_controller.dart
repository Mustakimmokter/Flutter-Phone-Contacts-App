import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/create/ui/screen/create_screen.dart';
import 'package:phone_contact_app/features/favorite/ui/screen/favorite_screen.dart';
import 'package:phone_contact_app/features/navbar_controller/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/home/ui/component/index.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class NavBarController extends StatelessWidget {
  const NavBarController({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavbarProvider>(
      create: (context) {
      return NavbarProvider();
    },
      child: NavBarControllerBody(),
    );
  }
}



class NavBarControllerBody extends StatelessWidget {
  NavBarControllerBody({Key? key}) : super(key: key);


  final List<Widget> body = [
    const HomeScreen(),
    const CreateScreen(),
     FavoriteScreen()
  ];


  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(animation: primaryAnimation, secondaryAnimation: secondaryAnimation,child: child);
        },
        child: body[navbarProvider.selectedIndex],
      ),
      bottomNavigationBar: CustomContainer(
        height: 60,
        radius: 0,
        color: Colors.transparent,
        boxDecoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, (index) {
            final List<IconData> icons = [
              Icons.home_filled,
              Icons.add_circle,
              Icons.star_rounded
            ];
            final List<String> labels = ['Home','Create','Favorite'];
            return CustomNavBar(
              index: index,
              onTap: (value) async {
                navbarProvider.getSelectedIndex(value!);
              },
              icon: icons[index],
              label: labels[index],
              size: navbarProvider.selectedIndex == index ? 27 : 24,
              selectedColor: navbarProvider.selectedIndex == index
                  ? brandSecondaryColor
                  : Colors.grey,
            );
          }),
        ),
      ),
    );
  }
}