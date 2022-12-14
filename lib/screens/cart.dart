import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/cart.dart';

import '../server_handler.dart';
import '../models/cartModel.dart';
import '../widgets/cart_item.dart';

class CartArguments {
  late final Map<String, dynamic> receivedMap;

  CartArguments(this.receivedMap);
}

class Cart extends StatefulWidget {
  static const routeName = '/cart-screen';

  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> _cart = [];
  int checkout = 0;
  final bool _firstExec = true;
  double translateX = 0.0;
  double translateY = 0.0;
  double width = 0.0;

  void getCartData(int buyerId) {
    ServerHandler().getCart(buyerId).then((value) => {
          setState(() {
            _cart = value;
          })
        });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CartArguments;
    if (_firstExec == true) {
      _firstExec == false;
      if(args.receivedMap['id'] != null){
        getCartData(int.parse(args.receivedMap['id']));
      }

    }
    setState(() {});


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 35.0, right: 30.0, top: 50.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shopice",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 23.0,
                        color: const Color(0xff4E8489),
                      ),
                    ),
                    if (args.receivedMap['image'] == null)
                      Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      )
                    else if (args.receivedMap['image'] != null)
                      Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://10.0.2.2:/shopice/assets/${args.receivedMap['image']}"),
                                fit: BoxFit.fitWidth),
                            shape: BoxShape.circle,
                            color: Colors.grey),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 284.0, bottom: 0.0),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.grey,
                  size: 35.0,
                ),
              ),
              if (args.receivedMap['id'] == null)
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff4E8489),
                          ),
                          strokeWidth: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text(
                          "Login To View Cart",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              if (args.receivedMap['id'] != null && _cart.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff4E8489),
                          ),
                          strokeWidth: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text(
                          "Add Products to see available products",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              if (args.receivedMap['id'] != null)
                Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 150,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _cart.length,
                            itemBuilder: (context, index) => CartItem(
                                carts: _cart[index], productIndex: index),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 13.9,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: const Color(0x9fFFC107),
                          ),
                          width: MediaQuery.of(context).size.width - 220,
                          height: 40.0,
                          child: GestureDetector(
                            onHorizontalDragUpdate: (event) async {
                              if (event.primaryDelta! > 20) {
                                _incrementTranslate();




                              }
                            },
                            child: Row(
                              children: [
                                paymentSuccessfull(),
                                width == 0.0
                                    ? Expanded(
                                        child: Center(
                                        child: Text(
                                          "Slide To Checkout($checkout)",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ))
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentSuccessfull() => Transform.translate(
        offset: Offset(translateX, translateY),
        child: AnimatedContainer(
            duration: Duration(microseconds: 200),
            curve: Curves.linear,
            width: width + 50,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: const Color(0xffFFC107)),
            child: width > 0.0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      Flexible(
                          child: Text(
                        ' Processing ',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ))
                    ],
                  )
                : Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 30.0,
                  )),
      );

  _incrementTranslate() async {
    int canLoop = -1;
    for (var i = 0; canLoop == -1; i++) {
      await Future.delayed(Duration(microseconds: 1), () {
        setState(() {
          if (translateX + 1 <
              MediaQuery.of(context).size.width - (270 + width)) {
            translateX += 1;
            width = MediaQuery.of(context).size.width - (270 + width);
          } else {
            setState(() {
              canLoop = 1;
            });
          }
        });
      });
    }
  }
}
