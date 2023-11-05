import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/create/ui/screen/create_screen.dart';
import 'package:phone_contact_app/features/details/ui/screen/details_screen.dart';
import 'package:phone_contact_app/features/my_profile/ui/screen/profile_screen.dart';
import 'package:phone_contact_app/features/otp/ui/screen/otp_screen.dart';
import 'package:phone_contact_app/features/sign_in/ui/screen/sign_in_screen.dart';
import 'package:phone_contact_app/features/splash/splash_screen.dart';
import 'package:phone_contact_app/shared/navbar_controller/nav_bar_controller.dart';

class AppRoute {

  static Route<dynamic> onGenerateRoute(RouteSettings settings){

    switch(settings.name){
      case '/splash':
        return MaterialPageRoute(builder: (context) => const SplashScreen(),settings: settings);
      case '/signIn':
        return MaterialPageRoute(builder: (context) => const SignInScreen(),settings: settings,);
      case '/navBarController':
        return MaterialPageRoute(builder: (context) => const NavBarController(),settings: settings);
      case '/detailsScreen':
        final params = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context) => DetailsScreen(name: params['name'], number: params['number'],id: params['id'],),settings: settings);
      case '/createScreen':
        return MaterialPageRoute(builder: (context) => const CreateScreen(),settings: settings);
      case '/myProfile':
        final params = settings.arguments as Map<dynamic,String>;
        return MaterialPageRoute(builder: (context) => MyProfileScreen(number: params['number']!,),settings: settings);
      case '/otpScreen':
       final params = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context) => OTPScreen(verificationID: params['verificationID'],phoneNumber: params['phoneNumber'],),settings: settings);
    }
    return MaterialPageRoute(builder: (context) => const SignInScreen(),settings: settings);
  }

}