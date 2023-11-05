import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/services/user_services/auth_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key,required this.phoneNumber, required this.verificationID});

  final String verificationID,phoneNumber;

  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            BackButton(
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            const Spacer(flex: 3),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(text: 'OTP Verification',fontSize: 20,fontWeight: FontWeight.w500,),
                const SizedBox(height: 10),
                CustomText(text: 'Enter the otp sent to +88$phoneNumber'),
                const SizedBox(height: 20),
                 Pinput(
                 controller: _pinController,
                  length: 6,
                  autofocus: true,
                  focusedPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: brandSecondaryColor),
                    ),
                  ),
                  defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey),
                    ),
                    ),

                ),
                SizedBox(height:  authServices.isOTPError? 05:0),
                SizedBox(
                  child: authServices.isOTPError ? const CustomText(
                    text: 'Something wrong please try again',
                    textColor: Colors.red,
                    fontSize: 14,
                  ):const SizedBox(),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(text: 'Didn\'t receive OTP?'),
                    GestureDetector(
                      onTap: (){
                        authServices.phoneNumberVerification(phoneNumber, context,'Resend');
                      },
                      child: const CustomText(text: ' Resend',textColor: brandColor),
                    ),

                  ],
                ),
                const SizedBox(height: 30),
                CustomBtn(
                  backgroundColor: brandSecondaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 6,),
                      const CustomText(text: 'Verify',textColor: Colors.white,),
                      const Spacer(flex: 4,),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: authServices.isVerifiedSuccess? const CircularProgressIndicator(color: Colors.white,):const SizedBox(),
                      ),
                      const SizedBox(width: 16,),
                    ],
                  ),
                  onPressed: (){
                    authServices.signInWithPhoneNumber(phoneNumber,verificationID, _pinController.text.trim(),context);
                  },
                ),
              ],
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
