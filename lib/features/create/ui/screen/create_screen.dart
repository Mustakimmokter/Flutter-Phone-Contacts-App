import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/features/home/ui/screen/home_screen.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/index.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);


  final TextEditingController nameCNTLR = TextEditingController();
  final TextEditingController numberCNTLR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final navbarProvider = Provider.of<NavbarProvider>(context);
    return SizedBox(
      height: SizeUtils.screenHeight,
      width: SizeUtils.screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const CustomTextOne(
                  text: 'Create new contact',
                  textColor: brandSecondaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 05),
                CustomContainer(
                  color: Colors.grey.shade400,
                  height: 4,
                  width: 70,
                ),
                const SizedBox(height: 30),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    CustomContainer(
                      height: 120,
                      width: 120,
                      alignment: Alignment.center,
                      color: Colors.grey.shade400,
                      borderWidth: 02,
                      child: const Icon(Icons.camera_alt,color: Colors.white,size: 40,),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: nameCNTLR,
                      onChanged: (name){
                        name = nameCNTLR.text;
                      },
                      hintText: 'First name',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: numberCNTLR,
                      keyBoardType: TextInputType.number,
                      onChanged: (number){
                        number = numberCNTLR.text;
                      },
                      hintText: 'Phone number',
                    ),
                    const SizedBox(height: 20),
                    _customCheckBox(
                      value: navbarProvider.isCheck,
                      onChanged: (value){
                        navbarProvider.getCheck(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomBtn(
                      height: SizeUtils.getProportionateScreenHeight(52),
                      backgroundColor: brandSecondaryColor,
                      borderRadius: 10,
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (_)=>HomeScreen()), (route) => false);
                        navbarProvider.getSelectedIndex(0);
                      },
                      text: 'Create',
                    ),
                     // Column(
                     //   children: List.generate(10, (index) => CustomTextOne(text: 'text')),
                     // ),
                  ],
                ),
              ),
            ),
           SizedBox(height: SizeUtils.getProportionateScreenHeight(50),),
          ],
        ),
      ),
    );
  }

  Widget _customCheckBox({required bool value, required Function(bool? value) onChanged}){
    return GestureDetector(
      onTap: (){
        onChanged(value);
      },
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        radius: 10,
        color: Colors.transparent,
        borderColor: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextOne(text: 'Add to favorite contact'),
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
