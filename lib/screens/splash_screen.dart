import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../server_handler.dart';
import '../screens/sellers_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLoadingSellers = false;
  dynamic _timer;

  void getSellers() {
    ServerHandler()
        .getSellers()
        .then((value) => Navigator.of(context).popAndPushNamed(SellersScreen.routeName))
        .catchError((e) => print(e));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer(
        const Duration(seconds: 3),
        () => {
              showLoadingSellers = true,
              setState(() {}),
              _timer = Timer(const Duration(seconds: 3), () =>{
                getSellers(),
              })

            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cacel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xffE6F3EC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shopice',
              style: GoogleFonts.pacifico(
                  color: const Color(0xff4E8489), fontSize: 28),
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
                  'Loading Sellers',
                  style: GoogleFonts.poppins(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
