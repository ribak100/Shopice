import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  static const routeName = '/about-screen';

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  double boxHeight = 400;
  double boxWidth = 300;
  var boxColor = Colors.white;
  double boxX = 0;
  double boxY = 1;

  double sizedHeight = 400;
  double sizedWidth = 600;

  double sizedHeightBox1 = 20;
  double sizedWidthBox1 = 50;

  double sizedHeightBox2 = 50;
  double sizedWidthBox2 = 50;

  void _expandBox(){

    setState(() {
      sizedHeight = 0;
      sizedWidth = 500;
      sizedHeightBox1 = 160;
      sizedWidthBox1 = 300;
      sizedHeightBox2 = 70;
      sizedWidthBox2 = 300;
    });

    }

    void _changeColor(){
    setState(() {
      boxColor = Colors.black;
    });
    }
  void _move(){

    setState(() {
      boxX = 0;
      boxX = -1;
      boxHeight = 100;

    });


  }


  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 1),() {
      _expandBox();
    _move();
    });


    return Scaffold(appBar: AppBar(
      title: Text(
        "Welcome to Shopice",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 23.0,
          color: Color(0xff4E8489),
        ),
      ),
      backgroundColor: Color(0xffE6F3EC),
    ),

    body: SingleChildScrollView(
      child: Container(color: Color(0xffF3F8FB),width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(color: Colors.white60,height: sizedHeight, width:sizedWidth ,duration: Duration(seconds: 3), alignment: Alignment(boxX,boxY),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 20, bottom: 30),
              child: AnimatedContainer(height: sizedHeightBox2, width:sizedWidthBox2, duration: Duration(seconds: 3), alignment: Alignment(boxX,boxY),
                child: Container( height: 75, width: 300,decoration: BoxDecoration(image: const DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThjnVY0Pk_hnM5j4bzp4qnp9-4AnkEyQkAmg&usqp=CAU"),
                    fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("We are excited to provide you with a convenient and seamless shopping experience.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Color(0xff000000),
                  )),
                )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 20, bottom: 30),
              child: AnimatedContainer(height: sizedHeightBox1, width:sizedWidthBox1, duration: Duration(seconds: 4), alignment: Alignment(boxX,boxY),
                child: Container( height: 149, width: 300,decoration: BoxDecoration(image: DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9BB6DK50w1vxjVH2q3INjJR9aX_n8w8Y03g&usqp=CAU"),
                    fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("Our app allows you to browse and purchase from a wide variety of products at the tap of a button. With easy payment options and fast delivery, you can have your items delivered straight to your doorstep.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Color(0xff000000),
                  )),
                )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 20, bottom: 30),
              child: AnimatedContainer(height: sizedHeightBox1, width:sizedWidthBox1, duration: Duration(seconds: 5), alignment: Alignment(boxX,boxY),
                child: Container( height: 149, width: 300,decoration: BoxDecoration(image: const DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP43c7hxx3TikNK_HOLPyEB4HDuuUzomEJQRf0hjfI30RymZL5ZBHQbyTJflduLO4Cb9k&usqp=CAU"),
                    fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("In addition to a wide selection of products, we also prioritize customer satisfaction. Our friendly and helpful customer service team is available to assist you with any questions or issues you may have.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: const Color(0xff000000),
                  )),
                )),
              ),
            ),

            Padding(//Goal
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container( height: 149, width: 300,decoration: const BoxDecoration(shape: BoxShape.circle,image: DecorationImage(
                  image: NetworkImage(
                      "https://clipartcraft.com/images/goals-clipart-achieve-7.png"),
                  fit: BoxFit.fitHeight, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, )), child: const Padding(
                padding: EdgeInsets.only(top: 5.0),

              )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container( height: 169, width: 300,decoration: BoxDecoration(image: const DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTufi8a1XUH9NiJpFGZyqZGiNi825yIN0Avqg&usqp=CAU"),
                  fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("To develop a shopping app that can strive to keep customers coming back by offering rewards, discounts, and other incentives, to increase the range of products it offers in order to attract a wider customer base and to provide a secured app for its users.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: const Color(0xff000000),
                )),
              )),
            ),

            Padding(//Vision
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container(  height: 149, width: 300,decoration: const BoxDecoration( shape: BoxShape.circle,image: DecorationImage(
                  image: NetworkImage(
                      "https://life.futuregenerali.in/Content/images/about/vision.jpg"),
                  fit: BoxFit.fitHeight, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, )), child: const Padding(
                padding: EdgeInsets.only(top: 5.0),

              )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container( height: 150, width: 300,decoration: BoxDecoration(image: const DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ28NQ7AjQMY9-5NoMb5hWOi88_HGUKIk9reg&usqp=CAU"),
                  fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("Our vision is to create the ultimate shopping destination for customers, offering an unparalleled selection of products, an easy and enjoyable shopping experience, and top-notch customer service", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: const Color(0xff000000),
                )),
              )),
            ),

            Padding(//Mission
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container( height: 149, width: 300,decoration: const BoxDecoration(shape: BoxShape.circle,image: DecorationImage(
                  image: NetworkImage(
                      "https://life.futuregenerali.in/Content/images/about/mission.jpg"),
                  fit: BoxFit.fitHeight, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, )), child: const Padding(
                padding: EdgeInsets.only(top: 5.0),

              )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 30, bottom: 30),
              child: Container( height: 149, width: 300,decoration: BoxDecoration(image: const DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3b9U9tt2mFuqHzDgUNuB_OcdQ1AOwf_LyemLn6A25_H9pUxZ77i0ZXbmqj6_cWo2JdUc&usqp=CAU"),
                  fit: BoxFit.fitWidth, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, ), borderRadius: BorderRadius.circular(30)), child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("Our mission is to revolutionize the shopping experience by offering a wide selection of high-quality products at competitive prices, all while providing excellent customer service and a seamless, secure checkout process.", textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: const Color(0xff000000),
                )),
              )),
            ),

            // Padding(//Values
            //   padding: const EdgeInsets.only(left: 50.0, top: 20),
            //   child: Container( height: 149, width: 300,decoration: const BoxDecoration(shape: BoxShape.circle,image: DecorationImage(
            //       image: NetworkImage(
            //           "https://life.futuregenerali.in/Content/images/about/values.jpg"),
            //       fit: BoxFit.fitHeight, repeat: ImageRepeat.noRepeat),color: Color(0xffD1DAE1, )), child: const Padding(
            //     padding: EdgeInsets.only(top: 5.0),
            //
            //   )),
            // ),


          ],
        ),
      ),
    ),);
  }
}



// Thank you for choosing our shopping app. Happy shopping!