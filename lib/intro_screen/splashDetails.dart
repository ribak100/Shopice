import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashDetails extends StatelessWidget {
  const SplashDetails({Key? key, required this.boxColor, required this.showLoadingSellers}) : super(key: key);
  final Color boxColor;
  final bool showLoadingSellers;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(seconds: 2),
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
    );
  }
}
