import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_contact_app/features/sign_up/provider/signup_provider.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController nameCTRL = TextEditingController();
  final TextEditingController numberCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();

  final _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final signupProvider = Provider.of<SignupProvider>(context);
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
              child: CustomTextOne(
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
                    const CustomTextOne(
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
                          ),
                          CustomTextField(
                            controller: numberCTRL,
                            keyBoardType: TextInputType.number,
                            hintText: 'Mobile number',
                            suffix: signupProvider.isCheckVisible?
                            const Icon(Icons.check,color: brandSecondaryColor,): SizedBox(),
                            onChanged: (number){
                              number = numberCTRL.text;
                              signupProvider.getCheckVisible(number);
                            },
                            validator: (number){
                              if(number == null || number.isEmpty){
                                return 'Required mobile number';
                              }else if(number.length < 11){
                                return 'Enter correct number';
                              }
                              return null;
                            },
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                          CustomTextField(
                            controller: passwordCTRL,
                            hintText: 'Password',
                            obscureText: signupProvider.isPasswordVisible? true : false,
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
                              if(password!.isEmpty || password == null){
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
                      text: 'Sign up',
                      onPressed: () {
                        if(_globalKey.currentState!.validate()){
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          nameCTRL.clear();
                          numberCTRL.clear();
                          passwordCTRL.clear();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Expanded(child: Divider(color: brandSecondaryColor,thickness: 1,)),
                        CustomTextOne(text: 'Or',textColor: brandSecondaryColor,),
                        Expanded(child: Divider(color:brandSecondaryColor,thickness: 1,)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomBtn(
                      height: 48,
                      backgroundColor: Colors.white,
                      borderColor: brandSecondaryColor,
                      text: 'Log in',
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
