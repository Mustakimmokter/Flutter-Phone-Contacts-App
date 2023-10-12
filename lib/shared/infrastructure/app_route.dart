import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/details/ui/screen/update_screen.dart';
import 'package:phone_contact_app/features/home/ui/screen/home_screen.dart';
import 'package:phone_contact_app/features/login/ui/screen/login_screen.dart';
import 'package:phone_contact_app/features/my_profile/ui/screen/profile_screen.dart';
import 'package:phone_contact_app/features/otp/ui/screen/otp_screen.dart';
import 'package:phone_contact_app/features/sign_up/ui/screen/sign_up_screen.dart';
import 'package:phone_contact_app/features/splash/splash_screen.dart';

class AppRoute {

  static Route<dynamic> onGenerateRoute(RouteSettings settings){

    switch(settings.name){
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen(),settings: settings);
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen(),settings: settings,);
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignUpScreen(),settings: settings);
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen(),settings: settings);
      case '/detailsScreen':
        return MaterialPageRoute(builder: (context) => const DetailsScreen(name: 'Mustakim', number: '01779-504864'),settings: settings);
      case '/myProfile':
        return MaterialPageRoute(builder: (context) => MyProfileScreen(),settings: settings);
    }
    return MaterialPageRoute(builder: (context) => LoginScreen(),settings: settings);
  }

}