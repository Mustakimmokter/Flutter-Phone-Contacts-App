import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_contact_app/features/sign_in/provider/login_provider.dart';
import 'package:phone_contact_app/shared/app_helper/index.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: SignInScreenBody(),
    );
  }
}


class SignInScreenBody extends StatelessWidget {
  SignInScreenBody({Key? key}) : super(key: key);

  final TextEditingController _numberController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: authService.isSignOut ? Column(
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
                  const Spacer(flex: 1),
                  const CustomText(
                    text: 'Welcome back',
                    textColor: brandSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                  const Spacer(flex: 5),
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
                          controller: _numberController,
                          hintText: 'Enter number',
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                          keyBoardType: TextInputType.number,
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 14),
                            child: CustomText(text: '+880',textColor: Colors.black54,),
                          ),
                          validator: (phnNumber){
                            if(phnNumber!.isEmpty){
                              return 'Required phone number';
                            }else if(AppValidation.isPhoneNumberValid(phnNumber)){
                              return null;
                            }else{
                              return 'Enter valid number';
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
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
                              child: authService.isSignIn? const CircularProgressIndicator(color: Colors.white,):const SizedBox(),
                            ),
                            const SizedBox(width: 16,),
                          ],
                        ),
                        onPressed: () {
                          if(_globalKey.currentState!.validate()){
                          if( _numberController.text[0] == '0'){
                            authService.phoneNumberVerification(_numberController.text, context, '');
                          }else{
                            authService.phoneNumberVerification('0${_numberController.text}', context, '');
                          }
                          }
                        },
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),

                ],
              ),
            ),
          ),
        ],
      ):
      const Center(child: CircularProgressIndicator(),),
    );
  }
}
