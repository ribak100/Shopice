import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../models/buying.dart';
import '../server_handler.dart';
import '../widgets/shippedItem.dart';
import '../models/buyer.dart';

class Shipped extends StatefulWidget {
  static const routeName = '/Shipped-screen';
  final Map<String, dynamic> receivedMap;

  const Shipped({Key? key, required this.receivedMap}) : super(key: key);

  @override
  State<Shipped> createState() => _ShippedState();
}

class _ShippedState extends State<Shipped> {
  List<BuyModel> _buyModel = [];
  late int interact;
  final int rating = 4;

  bool _firstExec = true;

  void getShippeds(int buyerId, String buyerName) {
    ServerHandler().getShippedOrderBuyer(buyerId, buyerName).then((value) => {
      setState(() {
        print("Value of Shipped Orders $value");
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
      getShippeds(int.parse(widget.receivedMap['id']), widget.receivedMap['name']);
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
                      padding: const EdgeInsets.only(top: 250.0),
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
                              "No Shipped Order",
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
                      height: MediaQuery.of(context).size.height - 75,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _buyModel.length,
                        itemBuilder: (context, index) => ShippedItem(
                          buyModel: _buyModel[index],
                          buyIndex: index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
