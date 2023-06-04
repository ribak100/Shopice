import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/cart.dart';

import '../server_handler.dart';
import '../models/cartModel.dart';
import '../models/seller.dart';
import '../models/product.dart';
import '../widgets/cart_item.dart';
import '../models/priceAndCount.dart';
import '../screens/payment.dart';

// class CartArguments {
//
//   late final Map<String, dynamic> receivedMap;
//   final Seller seller;
//   CartArguments(this.receivedMap, this.seller);
// }

class Cart extends StatefulWidget {

  const Cart({Key? key, required this.receivedMap, required this.seller})
      : super(key: key);
  final Map<String, dynamic> receivedMap;
  final Seller seller;

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
  List<Price> price = [];
  List<Count> count = [];
  List<Price> priceTotal = [];
  List<Count> countTotal = [];
  int totalToPay = 0;
  List<Total> calculatedTotal = [];
  late String buyerName;
  late int buyerId;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void getCartData(int buyerId) {
    ServerHandler().getCart(buyerId).then((value) => {
          setState(() {
            _cart = value;
          })
        });
  }

  List<Price> getPrice(String buyerName, int buyerId) {
    ServerHandler().getPrice(buyerName, buyerId).then((value) => {
          price = value.cast<Price>(),
        });
    //.catchError((e) => print(e));
    return price;
  }

  List<Count> getCount(String buyerName, int buyerId) {
    ServerHandler().getCount(buyerName, buyerId).then((value) => {
          count = value.cast<Count>(),
        });

    //.catchError((e) => print(e));
    return count;
  }

  //get total from buy
  Future<List<Total>> getTotalPrice(String buyerName, int buyerId) async {
    List<Total> total = [];
    total = await ServerHandler().getTotalPrice(buyerName, buyerId);

    return total;
  }

  int totalPrice(List<Total> total) {
    int totalPrice = 0;

    for (int i = 0; i < total.length; i++) {
      totalPrice += int.parse((total[i].totalPrice).toString());
    }

    return totalPrice;
  }

  void totalFunction() async {
    calculatedTotal = await getTotalPrice(buyerName, buyerId);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var args = ModalRoute.of(context)!.settings.arguments as CartArguments;
    buyerName = widget.receivedMap['name'];
    buyerId = int.parse(widget.receivedMap['id']);
    if (_firstExec == true) {
      _firstExec == false;
      if (widget.receivedMap['id'] != null) {
        getCartData(int.parse(widget.receivedMap['id']));
      }
    }

    return SingleChildScrollView(
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
                        if (widget.receivedMap['image'] == null)
                          Container(
                            height: 45.0,
                            width: 45.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          )
                        else if (widget.receivedMap['image'] != null)
                          Container(
                            height: 45.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}"),
                                    fit: BoxFit.fitWidth),
                                shape: BoxShape.circle,
                                color: Colors.grey),
                          )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 284.0, bottom: 0.0),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                      size: 35.0,
                    ),
                  ),
                  if (widget.receivedMap['id'] == null)
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
                  if (widget.receivedMap['id'] != null && _cart.isEmpty)
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
                  if (widget.receivedMap['id'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height -225,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _cart.length,
                                    itemBuilder: (context, index) => CartItem(
                                        carts: _cart[index],
                                        productIndex: index)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: 12.2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30.0, left: 19.0, top: 1.5),
                                    child: GestureDetector(
                                      //behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        totalFunction();
                                        totalToPay = totalPrice(calculatedTotal);
                                      },
                                      child: Container(
                                        height: 40.0,
                                        width: 150.0,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "  Total(#$totalToPay)",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.0,
                                            color: const Color(0x9f000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: const Color(0x9fFFC107),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 220,
                                    height: 40.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (totalToPay == 0) {
                                          var snackBar = const SnackBar(
                                            content: Text(
                                                'Select Products Before Sliding',
                                                style: TextStyle(fontSize: 18.0)),
                                            backgroundColor: Color(0xff4A777A),
                                            padding: EdgeInsets.only(left: 50.0),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      onHorizontalDragUpdate: (event) async {
                                        setState(() {
                                          totalFunction();
                                          totalToPay =
                                              totalPrice(calculatedTotal);

                                          if (totalToPay != 0) {
                                            if (event.primaryDelta! > 20) {
                                              _incrementTranslate();
                                              Future.delayed(
                                                  const Duration(seconds: 5), () {
                                                Navigator.pushNamed(
                                                    context, '/payment-screen',
                                                    arguments:
                                                        PaymentScreenArguments(
                                                            totalToPay,
                                                            widget.receivedMap,
                                                            widget.seller));
                                              });
                                            }
                                          }
                                        });
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
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ))
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                ],
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
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      Flexible(
                          child: Text(
                        ' Processing ',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )),
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xffffffff),
                          ),
                          strokeWidth: 2,
                        ),
                      )
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
