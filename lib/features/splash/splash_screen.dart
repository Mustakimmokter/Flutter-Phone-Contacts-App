
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/db/local_db.dart';
import 'package:phone_contact_app/features/db/table.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final userInfo = DbHelper.getData(DbTable.userInfo, DbTable.userInfo);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      if(userInfo != null){
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    authService.getUserProfile();
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}
