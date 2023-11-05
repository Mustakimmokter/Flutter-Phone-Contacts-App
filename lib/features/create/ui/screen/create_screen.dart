import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_contact_app/features/create/provider/create_provider.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/index.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatelessWidget {
   const CreateScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateProvider>(create: (context) => CreateProvider(),child: CreateScreenBody(),);
  }
}


class CreateScreenBody extends StatelessWidget {
  CreateScreenBody({Key? key}) : super(key: key);

  final TextEditingController nameCNTLR = TextEditingController();
  final TextEditingController numberCNTLR = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final userService = Provider.of<UserService>(context);
    final createProvider = Provider.of<CreateProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: SizeUtils.screenHeight / 15.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Spacer(flex: 1,),
            const SizedBox(height: 10,),
            Column(
              children: [
                const CustomText(
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
              ],
            ),
          const Spacer(flex: 10,),
            Form(
              key: _globalKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameCNTLR,
                    padding: const EdgeInsets.only(left: 14),
                    hintText: 'Contact name',
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                      // return RegExp(
                      //   // "^(?:[+0]9)?[0-9]{10,12}",
                      //   "^[0-9]{4} [0-9]{7}",
                      // ).hasMatch(name!)
                      //     ? null
                      //     : 'Format XXXX XXXXXXX';

                    },
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    controller: numberCNTLR,
                    padding: const EdgeInsets.only(left: 14),
                    keyBoardType: TextInputType.number,
                    hintText: 'Phone number',
                    validator: (number) {
                      if (number == null || number.isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(14),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ContainerAndCheckBox(isCheck: createProvider.isFavorite!, onChanged: (value){
                    createProvider.getFavorite(value!);
                  }, title: 'Add to favorite'),
                  const SizedBox(height: 30),
                  CustomBtn(
                    backgroundColor: brandSecondaryColor,
                    radius: 10,
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        final int random =  Random().nextInt(100)-1;
                        userService.addContact('${numberCNTLR.text}-$random',
                          name: nameCNTLR.text,
                          number: numberCNTLR.text,
                          isFavorite: createProvider.isFavorite,
                        );
                        Navigator.pushNamedAndRemoveUntil(context, '/navBarController', (route) => false);
                      }
                    },
                    text: 'Create',
                  ),
                ],
              ),
            ),
            const Spacer(flex: 10,),
          ],
        ),
      ),
    );
  }
}


