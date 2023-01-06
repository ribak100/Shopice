import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utility/colors.dart';

class QAndA extends StatefulWidget {
  const QAndA({Key? key}) : super(key: key);

  @override
  State<QAndA> createState() => _QAndAState();
}

class _QAndAState extends State<QAndA> {


  //1
  double q1height = 50;
  double q1width = 200;
  double radius1 = 0;
  bool visible1 = false;
  int color1 = 0;

  void _resize1() {
    if (q1height == 50) {
      setState(() {
        q1height = 170;
        q1width = 340;
        radius1 = 30;
        color1 =2;
      });
      Future.delayed(Duration(seconds: 2), (){
        setState(() {
          visible1 = true;
        });
      });
    } else if (q1height == 170) {
      setState(() {
        q1height = 50;
        q1width = 200;
        radius1 = 0;
        visible1 = false;
        Future.delayed(Duration(seconds: 2), (){
          setState(() {
            visible1 = false;
          });
        });

        color1=0;
      });
    }
  }

  //2
  double q2height = 50;
  double q2width = 200;
  double radius2 = 0;
  bool visible2 = false;
  int color2 = 1;

  void _resize2() {
    if (q2height == 50) {
      setState(() {
        q2height = 185;
        q2width = 340;
        radius2 = 30;
        color2 =3;
      });
      Future.delayed(Duration(seconds: 2), (){
        setState(() {
          visible2 = true;
        });
      });
    } else if (q2height == 185) {
      setState(() {
        q2height = 50;
        q2width = 200;
        radius2 = 0;
        visible2 = false;
        Future.delayed(Duration(seconds: 2), (){
          setState(() {
            visible2 = false;
          });
        });
        color2 =1;
      });
    }
  }

  //3
  double q3height = 50;
  double q3width = 200;
  double radius3 = 0;
  bool visible3 = false;
  int color3 = 2;

  void _resize3() {
    if (q3height == 50) {
      setState(() {
        q3height = 185;
        q3width = 340;
        radius3 = 30;
        color3 =0;
      });
      Future.delayed(Duration(seconds: 2), (){
        setState(() {
          visible3 = true;
        });
      });
    } else if (q3height == 185) {
      setState(() {
        q3height = 50;
        q3width = 200;
        radius3 = 0;
        visible3 = false;
        Future.delayed(Duration(seconds: 2), (){
          setState(() {
            visible3 = false;
          });
        });

        color3 =2;
      });
    }
  }



  //4
  double q4height = 50;
  double q4width = 200;
  double radius4 = 0;
  bool visible4 = false;
  int color4 = 3;

  void _resize4() {
    if (q4height == 50) {
      setState(() {
        q4height = 185;
        q4width = 340;
        radius4 = 30;
        color4 =1;
      });
      Future.delayed(Duration(milliseconds: 2000), (){
        setState(() {
          visible4 = true;
        });
      });
    } else if (q4height == 185) {
      setState(() {
        q4height = 50;
        q4width = 200;
        radius4 = 0;
        visible4 = false;
        Future.delayed(Duration(seconds: 2), (){
          setState(() {
            visible4 = false;
          });
        });

        color4 = 3;
      });
    }
  }



  //5
  double q5height = 50;
  double q5width = 200;
  double radius5 = 0;
  bool visible5 = false;
  int color5 = 0;

  void _resize5() {
    if (q5height == 50) {
      setState(() {
        q5height = 452;
        q5width = 340;
        radius5 = 30;
        color5 =2;
      });
      Future.delayed(Duration(milliseconds: 1300), (){
        setState(() {
          visible5 = true;
        });
      });
    } else if (q5height == 452) {
      setState(() {
        q5height = 50;
        q5width = 200;
        radius5 = 0;
        visible5 = false;
        Future.delayed(Duration(milliseconds: 1300), (){
          setState(() {
            visible5 = false;
          });
        });
        color5 =0;
      });
    }
  }


  //6
  double q6height = 50;
  double q6width = 200;
  double radius6 = 0;
  bool visible6 = false
  ; int color6 = 1;

  void _resize6() {
    if (q6height == 50) {
      setState(() {
        q6height = 182;
        q6width = 340;
        radius6 = 30;
        color6 =3;
      });
      Future.delayed(Duration(milliseconds: 1300), (){
        setState(() {
          visible6 = true;
        });
      });
    } else if (q6height == 182) {
      setState(() {
        q6height = 50;
        q6width = 200;
        radius6 = 0;
        visible6 = false;
        Future.delayed(Duration(milliseconds: 1300), (){
          setState(() {
            visible6 = false;
          });
        });
        color6 =1;
      });
    }
  }



  //7
  double q7height = 50;
  double q7width = 200;
  double radius7 = 0;
  bool visible7 = false
  ; int color7 = 2;

  void _resize7() {
    if (q7height == 50) {
      setState(() {
        q7height = 182;
        q7width = 340;
        radius7 = 30;
        color7 =0;
      });
      Future.delayed(Duration(milliseconds: 1300), (){
        setState(() {
          visible7 = true;
        });
      });
    } else if (q7height == 182) {
      setState(() {
        q7height = 50;
        q7width = 200;
        radius7 = 0;
        visible7 = false;
        Future.delayed(Duration(milliseconds: 1300), (){
          setState(() {
            visible2 = false;
          });
        });

        color7 =2;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopice",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 23.0,
            color: Color(0xff4E8489),
          ),
        ),
        backgroundColor: Color(0xffE6F3EC),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GestureDetector(
                    onTap: _resize1,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: q1height,
                      width: q1width,
                      decoration: BoxDecoration(
                          color: primaryColor[color1],
                          borderRadius: BorderRadius.circular(radius1)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "What is Shopice ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 5.0,right: 5.0),
                            child: Visibility(visible: visible1,
                              child: Text(
                                "Shopice is a shopping application that allow you to search through a wide variety of products and deliver then at your doorstep in a flash", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GestureDetector(
                    onTap: _resize2,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: q2height,
                      width: q2width,
                      decoration: BoxDecoration(
                          color: primaryColor[color2],
                          borderRadius: BorderRadius.circular(radius2)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Who can use ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0),
                            child: Visibility(visible: visible2,
                              child: Text(
                                "Anyone with internet connection and a device to access the app can place an order from any part of the world and get their desired products shipped to their doorsteps", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GestureDetector(
                    onTap: _resize3,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: q3height,
                      width: q3width,
                      decoration: BoxDecoration(
                          color: primaryColor[color3],
                          borderRadius: BorderRadius.circular(radius3)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "How to Signup ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0),
                            child: Visibility(visible: visible3,
                              child: Text(
                                "On the main screen, at the top-left corner is a drawer, click the drawer and you'll see a sign-up button, click the sign-up and provide all the requested information accurately", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25.0 ),
                child: GestureDetector(
                    onTap: _resize4,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: q4height,
                      width: q4width,
                      decoration: BoxDecoration(
                          color: primaryColor[color4],
                          borderRadius: BorderRadius.circular(radius4)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,),
                            child: Text(
                              "How to buy product ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0,),
                            child: Visibility(visible: visible4,
                              child: Text(
                                "Search for your desired product from the seller page, then click on buy now to purchase a single item or add all your desired products to cart and click the checkout to purchase", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GestureDetector(
                    onTap: _resize5,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1300),
                      height: q5height,
                      width: q5width,
                      decoration: BoxDecoration(
                          color: primaryColor[color5],
                          borderRadius: BorderRadius.circular(radius5)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,),
                            child: Text(
                              "How to Pay ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0,),
                            child: Visibility(visible: visible5,
                              child: Column(
                                children: [
                                  Text(
                                    "After clicking on 'Buy now' or sliding the 'CheckOut', there are 3 payment methods", textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      color: Colors.grey,
                                    ),softWrap: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                                    child: Text("\n1) Bank Transfer: this allow user to pay directly to the provided account details and uploading the payment slip for confirmation.\n\n2) Card Payment: Provide your card details accurately for secured processing of payment\n\n3) Payment On Delivery: this allow user to make payment at point of delivery!",textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.0,
                                        color: Colors.grey,
                                      ),softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0 ),
                child: GestureDetector(
                    onTap: _resize6,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1300),
                      height: q6height,
                      width: q6width,
                      decoration: BoxDecoration(
                          color: primaryColor[color6],
                          borderRadius: BorderRadius.circular(radius6)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,),
                            child: Text(
                              "I overpaid a product!", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0,),
                            child: Visibility(visible: visible6,
                              child: Text(
                                "If you mistakingly transfered more than the proposed amount for a product using bank transfer, contact Support Immediately to look into the case and have your money refunded", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 30.0 ),
                child: GestureDetector(
                    onTap: _resize7,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1300),
                      height: q7height,
                      width: q7width,
                      decoration: BoxDecoration(
                          color: primaryColor[color7],
                          borderRadius: BorderRadius.circular(radius7)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,),
                            child: Text(
                              "Other Issues ?", textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0,right: 5.0,),
                            child: Visibility(visible: visible7,
                              child: Text(
                                "in case you have any other issue thats not mentioned here, our support team us available 24/7 to attend to you as within a short period of time", textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
