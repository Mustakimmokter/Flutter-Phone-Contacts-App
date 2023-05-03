import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/loader/custom_animation_controller.dart';
import 'package:provider/provider.dart';

class AnimatedContainerExample extends StatelessWidget {
  const AnimatedContainerExample({super.key});


  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<CustomAnimationProvider>(context);
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            //loginProvider.changeValues();
            // loginProvider.startAnimation();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: loginProvider.sizeAnimationOne!.value,
                  height: loginProvider.sizeAnimationOne!.value,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    width: loginProvider.sizeAnimationOne!.value,
                    height: loginProvider.sizeAnimationOne!.value,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child:  Container(
                      margin: const EdgeInsets.all(15),
                      width: loginProvider.sizeAnimationOne!.value,
                      height: loginProvider.sizeAnimationOne!.value,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}