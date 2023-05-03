import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/create/provider/create_provider.dart';
import 'package:phone_contact_app/features/favorite/provider/favorite_provider.dart';
import 'package:phone_contact_app/features/home/provider/body_provider.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/login/provider/login_provider.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/features/sign_up/provider/signup_provider.dart';
import 'package:phone_contact_app/shared/infrastructure/app_route.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/widgets/loader/custom_animation_controller.dart';
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
      ChangeNotifierProvider<LoginProvider>(create: (context) {
        return LoginProvider();
      },),
      ChangeNotifierProvider<SignupProvider>(create: (context) {
        return SignupProvider();
      },),
      ChangeNotifierProvider<CustomAnimationProvider>(create: (context) {
        return CustomAnimationProvider();
      },),
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService(),),
      ChangeNotifierProvider<UserService>(create: (context) => UserService(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData(
        primarySwatch:  getMaterialColor(brandThirdColor),
        primaryColor:  getMaterialColor(brandColor),
        splashColor: brandSecondaryColor.withOpacity(.4),
      ),
    ));
  }
}


