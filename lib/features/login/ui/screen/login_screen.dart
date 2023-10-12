import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/login/provider/login_provider.dart';
import 'package:phone_contact_app/shared/app_helper/index.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/services/user_services/user.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      //backgroundColor: brandSecondaryColor,
      body: Column(
        children: [
          const CustomContainer(
            padding: EdgeInsets.only(left: 20),
            width: double.maxFinite,
            height: 200,
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
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Log in',
                          textColor: brandSecondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .5,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    authService.isEmailNotMatch? const CustomText(
                      text: 'Don\'t match, please try again',
                      textColor: Colors.red,
                      fontSize: 14,
                    ):const SizedBox(),
                   Form(
                     key: _globalKey,
                     child: Column(
                       children: [
                       CustomTextField(
                       controller: emailCTRL,
                       hintText: 'Enter email',
                       prefix: const Icon(Icons.email),
                       onChanged: (email){
                         email = emailCTRL.text;
                       },
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
                         CustomTextField(
                           controller: passwordCTRL,
                           hintText: 'Password',
                           obscureText: loginProvider.isPasswordVisible? true : false,
                           prefix: const Icon(Icons.lock),
                           suffix: GestureDetector(
                             child: Icon(
                               Icons.remove_red_eye,
                               color: loginProvider.isPasswordVisible ? Colors.grey : brandSecondaryColor,
                             ),
                             onTap: (){
                               loginProvider.getPasswordVisible();
                             },
                           ),
                           validator: (password){
                             if(password!.isEmpty){
                               return 'Required password';
                             }else if(password.length < 6){
                               return 'Password must be 6 characters up';
                             }
                             return null;
                           },
                         ),
                       ],
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
                          const CustomText(text: 'Login',textColor: Colors.white,),
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
                        if(_globalKey.currentState!.validate()){
                          authService.login(emailCTRL.text, passwordCTRL.text, context);

                        }
                        userService.getContacts();
                      },
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: brandSecondaryColor,thickness: 1,)),
                        CustomText(text: 'Or',textColor: brandSecondaryColor,),
                        Expanded(child: Divider(color:brandSecondaryColor,thickness: 1,)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomBtn(
                      height: 48,
                      backgroundColor: Colors.white,
                      borderColor: brandSecondaryColor,
                      text: 'Sign up',
                      textColor: brandSecondaryColor,
                      borderWidth: 1.5,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                    const SizedBox(height: 100),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
