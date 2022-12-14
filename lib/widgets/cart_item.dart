import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/cartModel.dart';
import '../utility/colors.dart';

class CartItem extends StatefulWidget {
  final int productIndex;
  final CartModel carts;

  const CartItem({Key? key, required this.carts, required this.productIndex})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();


}

class _CartItemState extends State<CartItem> {
  int counter = 0;
  bool checked = false;

  void printIfChecked(){
    if(this.checked == true){
      print("index "+ widget.productIndex.toString() +widget.carts.productName.toString() +" is Checked");
    }
    else if(this.checked == false){
      print("index "+ widget.productIndex.toString() +widget.carts.productName.toString() +" is unChecked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => printIfChecked(),
      child: Column(
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
                          margin: const EdgeInsets.only(left: 0.0, top: 0.0),
                          height: 165.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: primaryColor[(widget.productIndex + 1) % 4],
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
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5.0, top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Container(width: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () => setState(() {
                                              counter == 0
                                                  ? print('counter at 0')
                                                  : counter--;
                                            }),
                                            child: Icon(Icons.remove)),
                                        Text('${counter}'),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('set');
                                                counter++;
                                              });
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
                      onChanged: (value) {
                        setState(() {
                          this.checked = value!;
                        });
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
    );
  }
}
