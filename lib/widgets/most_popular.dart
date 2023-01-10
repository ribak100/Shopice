import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/models/buyer.dart';

import '../models/product.dart';
import '../utility/colors.dart';
import '../models/seller.dart';
import '../screens/product_detail_screen.dart';

class MostPopular extends StatelessWidget {
  final Product product;
  final int productIndex;
  final Seller seller;
  final Map<String, dynamic> receivedMap;
  const MostPopular(
      {Key? key, required this.product, required this.productIndex, required this.seller, required this.receivedMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product-detaail-screen', arguments: DetailProduct(product, seller, receivedMap)) as DetailProduct,
      child: Column(
        //image section

        children: [
          Container(padding: EdgeInsets.only(left: 5.0),
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 163.0),
                  height: 50.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffE9E6E6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,bottom: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff4A777A),
                            fontSize: 14, fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          '#' + product.pricePerKg!,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff4A777A),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 165.0,
                  width: 150.0,
                  margin: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 8.0, bottom: .0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    color: primaryColor[productIndex % 4],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primaryColor[productIndex % 4],
                          Colors.black12.withOpacity(0.0),
                        ]),
                  ),
                  child: Hero(
                    tag: "popular.${product.image!}",
                    child: Image.network(
                      "http://10.0.2.2:/shopice/assets/${product.image!}",
                    ),
                  ),
                ),
              ],
            ),
          ),

          //product name
        ],
      ),
    );
  }
}
