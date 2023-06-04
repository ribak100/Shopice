import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:shopice/intro_screen/intro_screen1.dart';
import 'package:shopice/intro_screen/intro_screen2.dart';
import 'package:shopice/intro_screen/splashDetails.dart';
import 'package:shopice/utility/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../intro_screen/intro_screen3.dart';
import '../server_handler.dart';
import '../screens/sellers_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.receivedMap}) : super(key: key);
  static const routeName = '/splash-screen';
  final Map<String, dynamic> receivedMap;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool showLoadingSellers = false;
  dynamic _timer;
  var boxColor = primaryColor[3];
  bool isCompleted = false;
  bool durationComplete = false;
  bool changeToDone = false;


  ParticleOptions particles = const ParticleOptions(
      baseColor: Color(0xffD5DEDC),
      spawnOpacity: 0.0,
      opacityChangeRate: 0.25,
      minOpacity: 0.1,
      maxOpacity: 0.4,
      particleCount: 70,
      spawnMaxRadius: 15.0,
      spawnMaxSpeed: 100.0,
      spawnMinSpeed: 30,
      spawnMinRadius: 7.0);
  final PageController _controller = PageController();

  void getSellers() {
    ServerHandler()
        .getSellers()
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> SellersScreen(receivedMap: widget.receivedMap, seller: value))))
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer(
        const Duration(seconds: 3),
        () => {
              boxColor = const Color(0xffE6F3EC),
              showLoadingSellers = true,
              setState(() {}),
              _timer = Timer(
                  const Duration(seconds: 3),
                  () => {
                        setState((){durationComplete = true;})
                      })
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((isCompleted == true) &&(durationComplete == true))
    {
      getSellers();
    }
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index){
              if(index == 3){
                Future.delayed(const Duration(seconds: 2),(){
                  setState(() {
                    isCompleted = true;
                  });
                });
              }
              if(index == 2){
                Future.delayed(const Duration(milliseconds: 300),(){
                  setState(() {
                    changeToDone = true;
                  });
                });
              }
            },
            controller: _controller,
            children: [
              const IntroScreen1(),
              const IntroScreen2(),
              const IntroScreen3(),
              SplashDetails(
                  boxColor: boxColor, showLoadingSellers: showLoadingSellers)
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){
                    setState(() {
                      _controller.jumpToPage(4);
                    });
                  }, child: const Text('Skip', style: TextStyle(color: Colors.black38),)),
                  SmoothPageIndicator(
                      effect: const WormEffect(type: WormType.thin),
                      controller: _controller,
                      count: 4),
                  changeToDone ? GestureDetector(onTap: (){
                    _controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                  }, child: const Text('Done', style: TextStyle(color: Colors.black38))) : GestureDetector(onTap: (){
                    _controller.nextPage(duration: const Duration(milliseconds: 900), curve: Curves.easeIn);
                  }, child: const Text('next', style: TextStyle(color: Colors.black38))),
                ],
              )),
        ],
      ),
    );
  }
}
