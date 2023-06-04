import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: Colors.blue[100]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
         AnimatedTextKit(animatedTexts: [
           TyperAnimatedText("Delivered To Your Doorstep", textStyle: TextStyle(color: Colors.black38), curve: Curves.bounceOut)
         ]),
          SizedBox(height: 140,),
          Container( height: 253, margin: EdgeInsets.only(bottom: 140),
      child: Lottie.network(
      "https://assets7.lottiefiles.com/private_files/lf30_woaw2kkp.json"),
    )
    ],
    ));
  }
}
