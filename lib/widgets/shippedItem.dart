import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/buying.dart';

import 'package:shopice/server_handler.dart';
import '../models/product.dart';
import '../utility/colors.dart';
import '../models/buyer.dart';
import '../screens/product_detail_screen.dart';

class ShippedItem extends StatefulWidget {
  final BuyModel buyModel;
  final int buyIndex;

  const ShippedItem(
      {Key? key, required this.buyModel, required this.buyIndex})
      : super(key: key);

  @override
  State<ShippedItem> createState() => _ShippedItemState();
}

class _ShippedItemState extends State<ShippedItem> {
  late String response;
  late String responseDelete;
  bool _firstExec = true;


  @override
  Widget build(BuildContext context) {
    // Used this to generate all list of user product to be view


    int interact;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
          child: Column(
            //image section

              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Container(
                          height: 250.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: primaryColor[widget.buyIndex % 4]
                                    .withOpacity(0.6),
                                width: 3.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 236.0,
                        width: 290.0,
                        margin: const EdgeInsets.only(
                            left: 7.0, right: 0.0, top: 8.0, bottom: .0),
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: primaryColor[widget.buyIndex % 4],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                primaryColor[widget.buyIndex % 4],
                                primaryColor[widget.buyIndex % 4]
                                    .withOpacity(0.0),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Image.network(
                                  height: 120.0,
                                  width: 120.0,
                                  "http://10.0.2.2:/shopice/assets/${widget.buyModel.image!}",
                                ),
                              ),
                              Text(
                                'Product Name: ' + widget.buyModel.productName!,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff4A777A),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Total Price  #' + widget.buyModel.total_price!,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff4A777A),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Quantity = ' + widget.buyModel.quantity!,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff4A777A),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Seller : ${widget.buyModel.sellerName}",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 0.0),
              child: GestureDetector(onTap: () {

                  showModalBottomSheet<dynamic>(context: context,builder: (BuildContext context) {
                  return Container(height: 200, width: 300,color: Colors.white, child: Column(children: [
                  Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                  child: Text("Confirm that selected product has been Delivered!", style: TextStyle(fontSize: 16),),
                  ),
                  Row(children: [
                  Padding(
                  padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                  child: FlatButton(color: Colors.grey, onPressed: () => Navigator.of(context).pop(), child: Text('No', style: TextStyle(color: Color(0xff4A777A)),)),
                  ),
                  FlatButton(color: Color(0xff4A777A), onPressed: () async{

                  String image =  await ServerHandler().getImage(int.parse(widget.buyModel.sellerId!), int.parse(widget.buyModel.buyerId!), widget.buyModel.price!, widget.buyModel.productName!);
                  String success = await ServerHandler().delivery(int.parse(widget.buyModel.sellerId!), image, int.parse(widget.buyModel.buyerId!), "delivered");

                  Navigator.of(context).pop();
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: LinearProgressIndicator(color:Color(0xff4A777A) ,),backgroundColor: Colors.white,));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Delivered!"),));
                  Navigator.of(context).pop();

                  }, child: Text('Yes i confirm', style: TextStyle(color: Colors.white),))
                  ],)
                  ],),
                  ); });


                  },
                child: Container(decoration: BoxDecoration(color: Color(0xffD5DEDC),border: Border.all(color: Colors.black38)),
                  height: 195,
                  width: 50,
                  child: RotatedBox(
                      quarterTurns: -1,
                      child: Center(
                          child: Text(
                            "Shipped",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 23.0,
                              color: Colors.black38,
                            ),
                          ))),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 2.0),
              child: IconButton(onPressed: () => print("Contact"), icon: Icon(Icons.check_box, size: 50, color: Color(0xff4A777A),)),
            )
          ],
        ),

      ],
    );
  }
}
