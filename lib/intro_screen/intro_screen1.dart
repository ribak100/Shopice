import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.deepPurple[100]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child:AnimatedTextKit(animatedTexts: [
              TyperAnimatedText("From The Comfort of Your Own Home", textStyle: TextStyle(color:Colors.black38), curve: Curves.bounceOut)
            ]),
          ),
          Container( height: 350, margin: EdgeInsets.only(bottom: 70),
            child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_Jejdj9.json' ),
          )
        ],
      ),
    );
  }
}
