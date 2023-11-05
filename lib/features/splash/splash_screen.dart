
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/splash/provider/provider.dart';
import 'package:phone_contact_app/shared/app_helper/network_chercker.dart';
import 'package:phone_contact_app/shared/db/local_db.dart';
import 'package:phone_contact_app/shared/db/table.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashProvider>(
      create: (context) => SplashProvider()..initCall(
          onPressed: (){
            final data = DbHelper.getData(DbTable.userInfo, DbTable.userInfo);
            if(data != null || data == ''){
              Navigator.pushNamedAndRemoveUntil(context, '/navBarController', (route) => false);
            }else{
              Navigator.pushNamedAndRemoveUntil(context, '/singIn', (route) => false);
            }
          }
      ),
      child: const SplashBody(),
    );
  }
}


class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context);
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}
