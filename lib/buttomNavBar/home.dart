import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product.dart';
import '../models/seller.dart';
import '../screens/porduct_screen.dart';
import '../screens/profile.dart';
import '../widgets/most_popular.dart';
import '../widgets/product_item.dart';

class Home extends StatelessWidget {
   Home({
    Key? key,
    required List<Product> products, required this.seller, required this.receivedMap,
  }) : _products = products, super(key: key);

   final Seller seller;
   final Map<String, dynamic> receivedMap;
  final List<Product> _products;
   final int rating = 4;
   int count = 4;

   int getInteractions() {
     int? interactionMax;

     if (_products.length == 1) {
       interactionMax = 0;
     } else if (_products.length == 2) {
       interactionMax = 1;
     } else if (_products.length == 3) {
       interactionMax = 2;
     } else if (_products.length >= 4) {
       interactionMax = 3;
     }

     for (int i = 0; i < _products.length; i++) {
       if (_products[i].interactionCount as int > interactionMax!) {
         interactionMax = i;
       }
     }

     return interactionMax!;
   }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              if (receivedMap['image'] == null)
                Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                )
              else if (receivedMap['image'] != null)
                GestureDetector(
                  onTap: () {
                    Future.delayed(Duration(seconds: 0), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(receivedMap: receivedMap)));
                    });
                  },
                  child: Hero(
                    tag: "profile_image.${receivedMap['image']}",
                    child: Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://10.0.2.2:/shopice/assets/${receivedMap['image']}"),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.grey),
                    ),
                  ),
                )
            ],
          ),
        ),

        // Loading widget
        if (_products.isEmpty)
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
                    'Seller has no product yet',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

        //List of Items

        Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: SizedBox(
            height: 130.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _products.length,
              itemBuilder: (context, index) => ProductItem(
                product: _products[index],
                productIndex: index,
                seller:  seller,
                receivedMap:  receivedMap,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 180.0, top: 10.0),
          child: Text(
            "Most Popular",
            style: GoogleFonts.poppins(
              //fontWeight: FontWeight.w500,
              fontSize: 25.0,
              color: const Color(0xff4E8489),
            ),
          ),
        ),
        //Most popolar widget
        if (!_products.isEmpty)
          if (_products.length < 4)
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: SizedBox(
                height: 225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  itemBuilder: (context, index) => MostPopular(
                    product: _products[getInteractions() - index],
                    productIndex: index,
                    seller:  seller,
                    receivedMap:  receivedMap,
                  ),
                ),
              ),
            ),
        if (!_products.isEmpty)
          if (_products.length >= 4)
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: SizedBox(
                height: 225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: count,
                  itemBuilder: (context, index) => MostPopular(
                      product: _products[getInteractions() - index],
                      productIndex: index,
                      seller:  seller,
                      receivedMap:  receivedMap),
                ),
              ),
            ),

        if (_products.isEmpty)
          SizedBox(
            height: 147.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0, top: 30.0),
              child: Text(
                "Interact with products to see the Most Popular",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

        Padding(
          padding: const EdgeInsets.only(right: 80.0),
          child: Text(
            "Whats The word around",
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              color: const Color(0xff4E8489),
            ),
          ),
        ),

        //comment and description box
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
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
                                            "http://10.0.2.2:/shopice/assets/${ seller.image}"),
                                        fit: BoxFit.fitWidth),
                                    shape: BoxShape.circle,
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 0.0, top: 5.0),
                                child: Text( seller.name!,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff4E8489),
                                      fontSize: 13,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, bottom: 3.0),
                                  width: 136.0,
                                  child: Row(
                                    children: [
                                      if (rating == 5)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                          ],
                                        ),
                                      if (rating == 4)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                          ],
                                        ),
                                      if (rating == 3)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                          ],
                                        ),
                                      if (rating == 2)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                          ],
                                        ),
                                      if (rating == 1)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                          ],
                                        ),
                                      if (rating == 0)
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
                                            Icon(Icons.star,
                                                color: Colors.white),
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
                            child: Text(seller.description as String,
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
    );
  }
}