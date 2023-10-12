import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/sign_up/provider/signup_provider.dart';
import 'package:phone_contact_app/shared/app_helper/index.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController nameCTRL = TextEditingController();
  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();

  final _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    final authService = Provider.of<AuthService>(context);
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
                text: 'Create\nAccount',
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
                    const CustomText(
                      text: 'Sign up',
                      textColor: brandSecondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameCTRL,
                            hintText: 'Your name',
                            prefix: const Icon(Icons.person),
                            onChanged: (name){
                              name = nameCTRL.text;
                            },
                          ),
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
                              }
                              return 'Enter valid email';
                            },
                          ),
                          CustomTextField(
                            controller: passwordCTRL,
                            hintText: 'Password',
                            obscureText: signupProvider.isPasswordVisible? true : false,
                            prefix: const Icon(Icons.lock),
                            suffix: GestureDetector(
                              child: Icon(
                                  Icons.remove_red_eye,
                                color: signupProvider.isPasswordVisible ? Colors.grey : brandSecondaryColor,
                              ),
                              onTap: (){
                                signupProvider.getPasswordVisible();
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
                    //SignUp Button
                    CustomBtn(
                      height: 50,
                      backgroundColor: brandSecondaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 5,),
                          const CustomText(text: 'Signup',textColor: Colors.white,),
                          const Spacer(flex: 3,),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: authService.isSignup? const CircularProgressIndicator(color: Colors.white,):const SizedBox(),
                          ),
                          const SizedBox(width: 16,),
                        ],
                      ),
                      onPressed: () {
                        authService.registrationWithPhone(emailCTRL.text,context);
                        // if(_globalKey.currentState!.validate()){
                        //   authService.registration(nameCTRL.text, emailCTRL.text, passwordCTRL.text, context);
                        //   nameCTRL.clear();
                        //   emailCTRL.clear();
                        //   passwordCTRL.clear();
                        // }
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
                     text: 'Login',
                      textColor: brandSecondaryColor,
                      borderWidth: 1.5,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                    ),
                    const SizedBox(height: 70),

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
