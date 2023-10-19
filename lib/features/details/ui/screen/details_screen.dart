import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/services/user_services/user.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/utils/size_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
import 'package:provider/provider.dart';


/*class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserService(),
      child: DetailsScreenBody(
        name: ,
      ),
    );
  }
}*/



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
    final TextEditingController numberCNTLR = TextEditingController(text: number);
    final TextEditingController nameCNTLR = TextEditingController(text: name);
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      backgroundColor: brandSecondaryColor,
      body: SizedBox(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 60,
              child: CustomBackBtn(
                onTap: () {
                  if(userService.isLoadAndUpdate){
                    userService.getLoadAndUpdate(false);
                    Navigator.pushNamedAndRemoveUntil(context, '/navBarController', (route) => false);
                  }else{
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            const Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomContainer(
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: nameCNTLR.text,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                  CustomText(
                    text: numberCNTLR.text,
                    textColor: Colors.grey,
                  ),
                ],
              ),
            ),
            // Message, Call, Favorite
            Positioned(
              left: 5,
              right: 5,
              top: 350,
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children : [
                       _rowAndButton('Message', Icons.message, () {}),
                       _rowAndButton('call', Icons.call, () {
                         userService.phoneCallDialer(number);
                       }),
                       _rowAndButton('Favorite', Icons.favorite_outline, () { }),
                     ],
                  ),
                ],
              ),
            ),
            // Edit button
            Positioned(
              right: 20,
              top: 290,
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
                        title: 'SAVE & CHANGE',
                        onPressed: (){
                          if(numberCNTLR.text.isNotEmpty && nameCNTLR.text.isNotEmpty){
                            final updateData = {'name':nameCNTLR.text,'number':numberCNTLR.text};
                            userService.updateContact(context, id, updateData: updateData);
                            final params = {'name': nameCNTLR.text,'number':numberCNTLR.text,'id':id};
                            userService.getLoadAndUpdate(true);
                           Navigator.pushNamedAndRemoveUntil(context, '/detailsScreen', (route) => false,arguments: params);
                          }
                        },
                      ),
                    );
                  },);
                },
              ),
            ),
            // Share
            Positioned(
              left: 20,
              right: 20,
              top: 460,
              child: Column(
                children: List.generate(3, (index) {
                  final List<IconData> icons = [ Icons.whatshot,Icons.telegram,Icons.share];
                  final List<String> titles = [ 'Whatsapp','Telegram','Share'];
                  final List<Color> colors = [Colors.green,Colors.blue,Colors.blue];
                  return CustomContainer(
                    margin: const EdgeInsets.only(bottom: 20,),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    borderColor: Colors.grey,
                    color: Colors.transparent,
                    height: 60,
                    radius: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: titles[index],fontWeight: FontWeight.w500,),
                        IconButton(
                            onPressed: (){
                              print('share');
                            },
                            icon: Icon(
                              icons[index],
                              size: 30,
                              color: colors[index],
                            )),
                      ],
                    ),
                  );
                }),
              ),

            ),

          ],
        ),
      ),
    );
  }
  
  Widget _rowAndButton(String label,IconData icon,VoidCallback onTap){
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
        color: brandColor,
      ),
    );
  }
}
