import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/login/provider/login_provider.dart';
import 'package:phone_contact_app/shared/app_helper/index.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: LoginScreenBody(),
    );
  }
}


class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key? key}) : super(key: key);

  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    //final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      //backgroundColor: brandSecondaryColor,
      body: Column(
        children: [
          const CustomContainer(
            padding: EdgeInsets.only(left: 20),
            width: double.maxFinite,
            height: 170,
            color: brandSecondaryColor,
            radius: 0,
            alignment: Alignment.centerLeft,
            child: SafeArea(
              child: CustomText(
                text: 'Welcome\nBack',
                textColor: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: .5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  const CustomText(
                    text: 'Welcome back',
                    textColor: brandSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                  Spacer(flex: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Your phone number',
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 05),
                      Form(
                        key: _globalKey,
                        child: CustomTextField(
                          controller: emailCTRL,
                          hintText: 'Enter number',
                          keyBoardType: TextInputType.number,
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 14),
                            child: CustomText(text: '+880',textColor: Colors.black54,),
                          ),
                          validator: (email){
                            if(AppValidation.isEmailValid(email!)){
                              return null;
                            }else if(email.isEmpty || email.isEmpty){
                              return 'Required email';
                            }else{
                              return 'Enter valid email';
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
                        height: 50,
                        backgroundColor: brandSecondaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(flex: 6,),
                            const CustomText(text: 'SING IN',textColor: Colors.white,),
                            const Spacer(flex: 4,),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: authService.isLogin? const CircularProgressIndicator(color: Colors.white,):const SizedBox(),
                            ),
                            const SizedBox(width: 16,),
                          ],
                        ),
                        onPressed: () {
                          final params = {'isComeToSignInPage': false};
                        Navigator.pushNamed(context, '/myProfile',arguments: params);
                          // if(_globalKey.currentState!.validate()){
                          //   authService.login(emailCTRL.text, passwordCTRL.text, context);
                          //
                          // }
                        },
                      ),
                    ],
                  ),
                  Spacer(flex: 5),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
