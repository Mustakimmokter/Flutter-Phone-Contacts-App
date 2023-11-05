import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/favorite/provider/favorite_provider.dart';
import 'package:phone_contact_app/features/my_profile/provider/profile_provider.dart';
import 'package:phone_contact_app/shared/app_helper/network_chercker.dart';
import 'package:phone_contact_app/shared/infrastructure/app_route.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:provider/provider.dart';





class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider(create: (context) => NetWorkService().netWorkController.stream, initialData: NetWorkStatus.offline),
      ChangeNotifierProvider<UserService>(create: (context) => UserService()),
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService(),),
      ChangeNotifierProvider<ProfileProvider>(create: (context) {
        return ProfileProvider();
      },),
    ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData(
        primarySwatch:  getMaterialColor(brandThirdColor),
        primaryColor:  getMaterialColor(brandColor),
        splashColor: brandSecondaryColor.withOpacity(.4),
      ),
    ),
    );
  }

}


