import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/create/provider/create_provider.dart';
import 'package:phone_contact_app/features/favorite/provider/favorite_provider.dart';
import 'package:phone_contact_app/features/home/provider/body_provider.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/infrastructure/app_route.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<NavbarProvider>(create: (context) {
        return NavbarProvider();
      },),
      ChangeNotifierProvider<BodyProvider>(create: (context) {
        return BodyProvider();
      },),
      ChangeNotifierProvider<FavoriteProvider>(create: (context) {
        return FavoriteProvider();
      },),
      ChangeNotifierProvider<ProfileProvider>(create: (context) {
        return ProfileProvider();
      },),
      ChangeNotifierProvider<CreateProvider>(create: (context) {
        return CreateProvider();
      },),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: '/login',
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData(
        primarySwatch:  getMaterialColor(brandThirdColor),
        primaryColor:  getMaterialColor(brandColor),
        splashColor: brandSecondaryColor.withOpacity(.4),
      ),
    ));
  }
}


