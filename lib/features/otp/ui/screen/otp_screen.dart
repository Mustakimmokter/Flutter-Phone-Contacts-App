import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.pinController});

  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Pinput(
             controller: pinController,
              length: 6,
              autofocus: true,
              focusedPinTheme: PinTheme(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red),
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
            SizedBox(height: 20),
            CustomBtn(
              onPressed: (){},
              text: 'Send',
            ),
          ],
        ),
      ),
    );
  }
}
