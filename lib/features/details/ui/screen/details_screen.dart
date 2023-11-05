import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/details/provider/details_provider.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/utils/size_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';



class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.name,
    required this.number,
    required this.id
  }) : super(key: key);

  final String name, number,id;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
     TextEditingController numberCNTLR = TextEditingController(text: number);
     TextEditingController nameCNTLR = TextEditingController(text: name);
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      backgroundColor: brandSecondaryColor,
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 60,
            child: CustomBackBtn(
              onTap: () {
                if(userService.isEditedDetails){
                  Navigator.pushNamedAndRemoveUntil(context, '/navBarController', (route) => false);
                  userService.getEditedDetails(false);
                }else{
                  Navigator.pop(context);
                }
              },
            ),
          ),
           Positioned(
            top: SizeUtils.screenHeight / 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: const CustomContainer(
              boxDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
            ),
          ),
          // Contact info.
          Positioned(
            left: 0,
            right: 0,
            top: 140,
            child: Column(
              children: [
                CustomContainer(
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  color: brandColor,
                  borderColor: Colors.white,
                  borderWidth: 02,
                  child: CustomText(
                    text: nameCNTLR.text[0],
                    textColor: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                CustomText(
                  text: nameCNTLR.text,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
                CustomText(
                  text: numberCNTLR.text,
                  textColor: Colors.grey,
                ),
                const SizedBox(height: 05),
                const Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children : [
                    _borderIconTextButton('call', Icons.call, () {
                      userService.phoneCallDialer(number);
                    }),
                    _borderIconTextButton('Message', Icons.message, () {
                      userService.phoneSMS(numberCNTLR.text);
                    },),
                    _borderIconTextButton('Share', Icons.share, () {
                      userService.shareContact(number);

                    },),
                  ],
                ),
              ],
            ),
          ),
          // Edit button
          Positioned(
            right: 20,
            top: SizeUtils.screenHeight / 2.6,
            child: IconButton(
              icon: const Icon(Icons.edit,size: 20,color: Colors.grey,),
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                  return CustomContainer(
                    padding: const EdgeInsets.only(top: 07, bottom: 20, left: 20, right: 20),
                    height: SizeUtils.getProportionateScreenHeight(600),
                    boxDecoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30)),
                    ),
                    child: CustomModalSheet(
                      header: 'Update Contact',
                      nameCNTLR: nameCNTLR,
                      numberCNTLR: numberCNTLR,
                      nameChanged: (nameValue){
                        nameValue = nameCNTLR.text;
                      },
                      numberChanged: (numberValue){
                        numberValue = numberCNTLR.text;
                      },
                      title: 'Submit',
                      onPressed: (){
                        if(numberCNTLR.text.isNotEmpty && nameCNTLR.text.isNotEmpty){
                          userService.getEditedDetails(true);
                          final params = {'name': nameCNTLR.text,'number':numberCNTLR.text,'id':id};
                          Navigator.pushNamedAndRemoveUntil(context, '/detailsScreen', (route) => false,arguments: params);
                        }
                      },
                    ),
                  );
                },);
              },
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            bottom: SizeUtils.screenHeight / 5,
            child: CustomBtn(
              backgroundColor: brandSecondaryColor,
              text: 'Save & Change',
              onPressed: (){
                  final updateData = {'name':nameCNTLR.text,'number':numberCNTLR.text};
                  userService.updateContact(context, id, updateData: updateData);
                  userService.getEditedDetails(false);
                  Navigator.pushNamedAndRemoveUntil(context, '/navBarController', (route) => false);
              },
            ),
          ),

        ],
      ),
    );
  }
  
  Widget _borderIconTextButton(String label,IconData icon,VoidCallback onTap,[Color? color]){
    return CustomContainer(
      height: 60,
      width: 90,
      radius: 10,
      color: Colors.transparent,
      borderColor: Colors.grey,
      child: IconAndTextBtn(
        label: label,
        onTap: onTap,
        icon: icon,
        color: color ?? brandColor,
      ),
    );
  }
}
