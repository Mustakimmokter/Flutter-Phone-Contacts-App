import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_contact_app/features/create/provider/create_provider.dart';
import 'package:phone_contact_app/features/home/provider/navbar_provider.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/index.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);

  final TextEditingController nameCNTLR = TextEditingController();
  final TextEditingController numberCNTLR = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final createProvider = Provider.of<CreateProvider>(context);
    return SizedBox(
      height: SizeUtils.screenHeight,
      width: SizeUtils.screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                const SizedBox(height: 30),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    ProfileContainer(
                      margin: const EdgeInsets.only(left: 40, top: 40),
                      iconBorderColor: Colors.transparent,
                      iconColor: createProvider.image == null
                          ? Colors.white
                          : Colors.transparent,
                      decorationImage: createProvider.image != null
                          ? DecorationImage(
                              image: FileImage(File(createProvider.image!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                      onTap: () {
                        createProvider.getImagePicker();
                      },
                      iconTap: () {
                        createProvider.getImagePicker();
                      },
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameCNTLR,
                            hintText: 'First name',
                            onChanged: (name) {
                              name = nameCNTLR.text;
                            },
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return 'Please enter the contact name';
                              }
                              return null;
                            },
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: numberCNTLR,
                            keyBoardType: TextInputType.number,
                            hintText: 'Phone number',
                            onChanged: (number) {
                              number = numberCNTLR.text;
                            },
                            validator: (number) {
                              if (number == null || number.isEmpty) {
                                return 'Please enter the contact number';
                              }else if (number.length < 10){
                                return 'Number must be 11 Character';

                              }
                              return null;
                            },
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ContainerAndCheckBox(
                      title: 'Add to favorite contact',
                      isCheck: createProvider.isCheck,
                      onChanged: (value) {
                        createProvider.getCheck(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomBtn(
                      height: SizeUtils.getProportionateScreenHeight(52),
                      backgroundColor: brandSecondaryColor,
                      borderRadius: 10,
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          navbarProvider.getSelectedIndex(0);
                        }
                      },
                      text: 'Create',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.getProportionateScreenHeight(50),
            ),
          ],
        ),
      ),
    );
  }
}
