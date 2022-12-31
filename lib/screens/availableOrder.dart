import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../models/buying.dart';
import '../server_handler.dart';
import '../models/seller.dart';
import '../models/product.dart';
import '../widgets/availableOrderItem.dart';
import '../models/buyer.dart';

class AvailableOrder extends StatefulWidget {
  static const routeName = '/availableOrder-screen';
  final Map<String, dynamic> receivedMap;

  const AvailableOrder({Key? key, required this.receivedMap}) : super(key: key);

  @override
  State<AvailableOrder> createState() => _AvailableOrderState();
}

class _AvailableOrderState extends State<AvailableOrder> {
  List<BuyModel> _buyModel = [];
  late int interact;
  final int rating = 4;

  bool _firstExec = true;
  List<Buyer> _buyer = [];

  void getAvailableOrders(int sellerId, String sellerName) {
    ServerHandler().getAvailableProducts(sellerId, sellerName).then((value) => {
      setState(() {
        print("Value of Avalilable Orders $value");
        _buyModel = value;
      })
    });
    //.catchError((e) => print(e));
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
    if (_firstExec == true) {
      getAvailableOrders(int.parse(widget.receivedMap['id']), widget.receivedMap['name']);
      _firstExec = false;
    }

    setState(() { });
    print(widget.receivedMap['id']);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}" ),
                                  fit: BoxFit.fitWidth),
                              shape: BoxShape.circle,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),

                  // Loading widget
                  if (_buyModel.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
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
                              "No Order Available",
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),

                  //List of Items
                  //setState(() { }),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: SizedBox(
                      height: 490.0,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _buyModel.length,
                        itemBuilder: (context, index) => AvailableOrderItem(
                          buyModel: _buyModel[index],
                          buyIndex: index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //comment and description box
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0, top: 7.0
                ),
                child: Column(
                  children: [
                    Container(
                      //margin: EdgeInsets.only(top: 15.0),
                        height: 105.0,
                        width: 350.0,
                        child: Container(
                            margin: EdgeInsets.only(top: 20.0),
                            decoration: BoxDecoration(
                                color: Color(0xffE9E6E6),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                      EdgeInsets.only(left: 30.0, top: 3.0),
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}"),
                                              fit: BoxFit.fitWidth),
                                          shape: BoxShape.circle,
                                          color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 0.0, top: 5.0),
                                      child: Text(widget.receivedMap['name'],
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff4E8489),
                                            fontSize: 13,
                                          )),
                                    ),

                                    // Seller description and ratings
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 0.0, bottom: 3.0),
                                        width: 136.0,
                                        child: Row(
                                          children: [
                                            if (rating == 5)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                ],
                                              ),
                                            if (rating == 4)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.white),
                                                ],
                                              ),
                                            if (rating == 3)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                ],
                                              ),
                                            if (rating == 2)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                ],
                                              ),
                                            if (rating == 1)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow[700]),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                ],
                                              ),

                                            if (rating == 0)
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                  Icon(Icons.star, color: Colors.white),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    )

                                    //Text(),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 33.0, bottom: 5),
                                  child: Text(widget.receivedMap['description'],
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 9.5,
                                      )),
                                ),
                              ],
                            ))),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
