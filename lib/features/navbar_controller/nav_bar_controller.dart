import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/create/ui/screen/create_screen.dart';
import 'package:phone_contact_app/features/favorite/ui/screen/favorite_screen.dart';
import 'package:phone_contact_app/features/navbar_controller/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/home/ui/component/index.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class NavBarController extends StatelessWidget {
  NavBarController({Key? key}) : super(key: key);

  final TextEditingController numberCNTLR = TextEditingController();
  final TextEditingController nameCNTLR = TextEditingController();

  List<Widget> body = [
    const HomeScreen(),
    const FavoriteScreen(),
    CreateScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: ListenableProvider(create: (context) => AuthService(),
      child: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(animation: primaryAnimation, secondaryAnimation: secondaryAnimation,child: child);
        },
        child: body[navbarProvider.selectedIndex],
      ),
      ),
      drawer: CustomContainer(
        width: SizeUtils.getProportionateScreenWidth(265),
        radius: 0,
        color: Colors.white,
        child: const CustomDrawer(),
      ),
      bottomNavigationBar: CustomContainer(
        height: 60,
        radius: 0,
        color: Colors.transparent,
        boxDecoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, (index) {
            final List<IconData> icons = [
              Icons.person,
              Icons.star,
              Icons.add_circle,
            ];
            final List<String> labels = ['Home','Favorite','Create'];
            return Consumer<NavbarProvider>(
              builder: (context, navbarProvider, child) {
                return CustomNavBar(
                  index: index,
                  onTap: (value) async {
                    navbarProvider.getSelectedIndex(value!);
                  },
                  icon: icons[index],
                  label: labels[index],
                  size: navbarProvider.selectedIndex == index? 27:25,
                  selectedColor: navbarProvider.selectedIndex == index
                      ? brandSecondaryColor
                      : Colors.grey,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}