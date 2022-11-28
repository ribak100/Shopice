import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/server_handler.dart';

import '../models/product.dart';
import '../utility/colors.dart';
import '../models/seller.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final int productIndex;

  const ProductItem(
      {Key? key, required this.product, required this.productIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int interact;
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(
          ProductScreenDetails.routeName,
          arguments: product,
        ),
        interact = product.interactionCount!,
        interact +=1,
        ServerHandler().getProductInteraction(
            interact, product.name!, product.sellerId!),
        print("product name = ${product.name!}"),
        print("interaction = ${interact}"),
        print("sellerID = ${product.sellerId!}"),
      },
      child: Column(
        //image section

        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: primaryColor[productIndex % 4].withOpacity(0.6),
                        width: 3.0),
                  ),
                ),
                Container(
                  height: 65.0,
                  width: 65.0,
                  margin: const EdgeInsets.only(
                      left: 7.0, right: 0.0, top: 8.0, bottom: .0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor[productIndex % 4],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          primaryColor[productIndex % 4],
                          primaryColor[productIndex % 4].withOpacity(0.0),
                        ]),
                  ),
                  child: Image.network(
                    "http://10.0.2.2:/shopice/assets/${product.image!}",
                  ),
                ),
              ],
            ),
          ),

          //product name
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              product.name!,
              style: GoogleFonts.poppins(
                color: const Color(0xff4A777A),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
