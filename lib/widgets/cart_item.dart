

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopice/server_handler.dart';

import '../models/cartModel.dart';
import '../screens/cart.dart';
import '../utility/colors.dart';
import '../models/buying.dart';
import '../models/priceAndCount.dart';



///UNUSED APIS



class CartItem extends StatefulWidget {
  final int productIndex;
  final CartModel carts;

  CartItem({Key? key, required this.carts, required this.productIndex})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 1;
  bool checked = false;
  bool _first_execution = false;

  List<Price> price = [];
  List<Count> count = [];
  late int interact;
  final int rating = 4;


  @override
  Widget build(BuildContext context) {
    if(_first_execution == false){
      ServerHandler().deleteInstantFromBuy(widget.carts.buyerId!, widget.carts.buyerName!);
      _first_execution = true;
    }
    //CartData cartData = CartData();

    return GestureDetector(
      onTap: () => print("Object Clicked"),
      child: Column(
        children: [
          Column(
            //image section

            children: [
              Container(
                padding: EdgeInsets.only(left: 5.0),
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 47.0, left: 30.0, bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor[widget.productIndex % 4],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                primaryColor[widget.productIndex % 4],
                                Colors.black12.withOpacity(0.0),
                              ]),
                        ),
                        height: 165,
                        child: Row(
                          children: [
                            Container(
                              height: 165.0,
                              width: 150.0,
                              margin: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                                color: primaryColor[widget.productIndex % 4],
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.center,
                                    colors: [
                                      primaryColor[widget.productIndex % 4],
                                      Colors.black12.withOpacity(0.0),
                                    ]),
                              ),
                              child: Image.network(
                                "http://10.0.2.2:/shopice/assets/${widget.carts.image!}",
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 0.0, top: 0.0),
                              height: 165.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color:
                                    primaryColor[(widget.productIndex + 1) % 4],
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.center,
                                    colors: [
                                      primaryColor[widget.productIndex % 4],
                                      Colors.black12.withOpacity(0.0),
                                    ]),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 5.0, top: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.carts.sellerName!,
                                      softWrap: true,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0x8f000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      widget.carts.productName!,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff4A777A),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '#' + widget.carts.price!,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff4A777A),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: Container(
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: ()  async{
                                                  setState(() {
                                                    _first_execution = true;
                                                    counter == 1
                                                        ? print(
                                                        'counter at 1')
                                                        : this.counter--;
                                                    print("counter inside setState is $counter");
                                                  });

                                      String image;
                                      image = await ServerHandler().getImage(widget.carts.sellerId!, widget.carts.buyerId!, widget.carts.price!, widget.carts.productName!);
                                      await ServerHandler().quantity(widget.carts.sellerId!,image , widget.carts.buyerId!,this.counter);
                                      int totalPrice = int.parse(widget.carts.price!) * this.counter;
                                      print(totalPrice);
                                      ServerHandler().total_price(widget.carts.sellerId!,image , widget.carts.buyerId!,totalPrice);



                                      }
                                      ,
                                                child: Icon(Icons.remove)),
                                            Text('${counter}'),
                                            GestureDetector(
                                                onTap: () async{

                                                    String image;
                                                    image = await ServerHandler().getImage(widget.carts.sellerId!, widget.carts.buyerId!, widget.carts.price!, widget.carts.productName!);
                                                    this.counter++;
                                                    await ServerHandler().quantity(widget.carts.sellerId!,image , widget.carts.buyerId!,this.counter);
                                                    int totalPrice = int.parse(widget.carts.price!) * this.counter;
                                                    print(totalPrice);
                                                    ServerHandler().total_price(widget.carts.sellerId!,image , widget.carts.buyerId!,totalPrice);


                                                },
                                                child: Icon(Icons.add)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Checkbox(
                          value: this.checked,
                          onChanged: (value) async{

                            this.checked = value!;

                            print(value);
                            if(this.checked == true) {
                                final uri = Uri.parse(
                                    "http://10.0.2.2:/shopice/api/buyer/buy");
                                var request =
                                http.MultipartRequest('POST', uri);
                                request.fields['buyer_id'] =
                                    widget.carts.buyerId.toString();
                                request.fields['seller_id'] =
                                    widget.carts.sellerId.toString();
                                request.fields['seller_name'] =
                                widget.carts.sellerName!;
                                request.fields['buyer_name'] =
                                widget.carts.buyerName!;
                                request.fields['price'] =
                                widget.carts.price!;
                                request.fields['product_name'] =
                                widget.carts.productName!;
                                request.fields['image'] =
                                    widget.carts.image!.toString();
                                request.fields['total_price'] =
                                widget.carts.price!;

                                var response = await request.send();

                                if (response.statusCode == 200) {
                                  var snackbar = SnackBar(
                                    content: Text(
                                        'Product Added To Cart!',
                                        style: TextStyle(fontSize: 20.0)),
                                    backgroundColor:
                                    const Color(0xff4A777A),
                                    padding: EdgeInsets.only(left: 50.0),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else if (response.statusCode == 500) {
                                  var snackbar = SnackBar(
                                    content: Text('Server Error!',
                                        style: TextStyle(fontSize: 20.0)),
                                    backgroundColor:
                                    const Color(0xff4A777A),
                                    padding: EdgeInsets.only(left: 50.0),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else {
                                  var snackbar = SnackBar(
                                    content: Text(
                                        'ERROR WHILE PERFORMING OPPERATION\n CONTACT SUPPORT!',
                                        style: TextStyle(fontSize: 20.0)),
                                    backgroundColor:
                                    const Color(0xff4A777A),
                                    padding: EdgeInsets.only(left: 50.0),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }



                            }
                            else if(this.checked == false){
                              String image;

                              image = await ServerHandler().getImage(widget.carts.sellerId!, widget.carts.buyerId!, widget.carts.price!, widget.carts.productName!);


                              ServerHandler().deleteFromBuy(widget.carts.buyerId!, image);


                            }


                            //print(" Total price is ${getTotalPrice(_price, _count)}");





                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Divider(
                  thickness: 1.0,
                  color: Colors.black26,
                  height: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
