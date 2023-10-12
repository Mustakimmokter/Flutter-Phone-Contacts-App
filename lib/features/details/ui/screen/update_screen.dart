import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/color_utils.dart';
import 'package:phone_contact_app/shared/utils/size_utils.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.name,
    required this.number,
  }) : super(key: key);

  final String name, number;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    final TextEditingController numberCNTLR = TextEditingController(text: number);
    final TextEditingController nameCNTLR = TextEditingController(text: name);
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
                  Navigator.pop(context);
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
                      text: name[0],
                      textColor: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: name,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                  CustomText(
                    text: number,
                    textColor: Colors.grey,
                  ),
                ],
              ),
            ),
            // Message, Call, Favorite
            Positioned(
              left: 5,
              right: 5,
              top: 340,
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children : List.generate(3, (index) {
                       final List<IconData> icons = [
                         Icons.message,
                         Icons.call,
                         Icons.star_border,
                       ];
                       final List<String> label = [
                         'Message',
                         'Call',
                         'Favorite'
                       ];
                       return CustomContainer(
                         height: 60,
                         width: 90,
                         radius: 10,
                         color: Colors.transparent,
                         borderColor: Colors.grey,
                         child: IconAndTextBtn(
                           label: label[index],
                           onTap: (){},
                           icon: icons[index],
                           color: brandColor,
                         ),
                       );
                     }),
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
                        title: 'Update',
                        onPressed: (){
                          if(numberCNTLR.text.isNotEmpty && nameCNTLR.text.isNotEmpty){
                            Navigator.pop(context);
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
}
