import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/sign_up/ui/screen/sign_up_screen.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      //backgroundColor: brandSecondaryColor,
      body: Column(
        children: [
          CustomContainer(
            padding: EdgeInsets.only(left: 20),
            width: double.maxFinite,
            height: 200,
            color: brandSecondaryColor,
            radius: 0,
            alignment: Alignment.centerLeft,
            child: SafeArea(
              child: CustomTextOne(
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
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextOne(
                      text: 'Log in',
                      textColor: brandSecondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: emailCTRL,
                      hintText: 'Email/Phone',
                      suffix: Icon(Icons.check),
                    ),
                    CustomTextField(
                      controller: passwordCTRL,
                      hintText: 'Password',
                      obscureText: true,
                      suffix: Icon(Icons.remove_red_eye),
                    ),
                    SizedBox(height: 20),
                    CustomBtn(
                      height: 50,
                      backgroundColor: brandSecondaryColor,
                      text: 'Log in',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));
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
                      text: 'Sign up',
                      textColor: brandSecondaryColor,
                      borderWidth: 1.5,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 100),

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
