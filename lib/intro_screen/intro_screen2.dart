import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: Colors.pink[100]),child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
          AnimatedTextKit(animatedTexts: [
          TyperAnimatedText("Browse Through Variety Of Products", textStyle: TextStyle(color: Colors.black38), curve: Curves.bounceOut)
        ]),
        SizedBox(height: 140,),
        Container(height: 250, margin: EdgeInsets.only(bottom: 140),
          child: Lottie.network(
              'https://assets3.lottiefiles.com/packages/lf20_6wutsrox.json'),
        )
      ],
    ),);
  }
}
