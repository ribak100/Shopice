import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_background/animated_background.dart';
import 'package:shopice/utility/colors.dart';

import '../server_handler.dart';
import '../screens/sellers_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.receivedMap}) : super(key: key);
  static const routeName = '/splash-screen';
  final Map<String, dynamic> receivedMap;

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  bool showLoadingSellers = false;
  dynamic _timer;
  var boxColor = primaryColor[3];

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

  void getSellers(){
    ServerHandler()
        .getSellers()
        .then((value) => Navigator
          .pushNamed(context, '/sellers_screen', arguments: ScreenArguments(value,
        widget.receivedMap
    )))
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer(
        const Duration(seconds: 3),
        () => {
          boxColor = Color(0xffE6F3EC) ,
              showLoadingSellers = true,
              setState(() {}),
              _timer = Timer(
                  const Duration(seconds: 3),
                  () => {
                        getSellers(),
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
    return Scaffold(
      body: AnimatedContainer(duration: Duration(seconds: 2),
        alignment: Alignment.center,
        color: boxColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1), curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Padding(padding: EdgeInsets.only(top: value * 50,),child: child,),
                );
              },
              child: Text(
                'Shopice',
                style: GoogleFonts.pacifico(
                    color: const Color(0xff4E8489), fontSize: 28),
              ),
            ),
            if (showLoadingSellers)
              const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff4E8489),
                    ),
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            if (showLoadingSellers)
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Text(
                  'Loading',
                  style: GoogleFonts.poppins(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
