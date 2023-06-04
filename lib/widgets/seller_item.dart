
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/sellers_screen.dart';

import '../models/seller.dart';
import '../screens/porduct_screen.dart';

class SellerItem extends StatelessWidget {
  final Seller seller;
  final Color backgroundColor;
  final rating = 4;
  final Map<String, dynamic> receivedMap;

  const SellerItem({
    Key? key,
    required this.seller,
    required this.backgroundColor, required this.receivedMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapResponse = <String, dynamic>{};
    mapResponse['id'] = receivedMap['id'];
    mapResponse['name'] = receivedMap['name'];
    mapResponse['email'] = receivedMap['email'];
    mapResponse['image'] = receivedMap['image'];
    mapResponse['address'] = receivedMap['address'];
    mapResponse['phone_number'] = receivedMap['phone_number'];
    mapResponse['postal_code'] = receivedMap['postal_code'];
    mapResponse['shipping_address'] = receivedMap['shipping_address'];
    mapResponse['country'] = receivedMap['country'];
    mapResponse['nationality'] = receivedMap['nationality'];
    return GestureDetector(
      onTap: () {
        print(mapResponse);
        Navigator
            .push(context, MaterialPageRoute(builder: (context)=>ProductScreen(seller: seller, receivedMap: receivedMap)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 30.0),
                  child: SizedBox(
                    width: 164.0,
                    child: Text(
                      seller.name!,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 164.0,
                    padding: const EdgeInsets.only(left: 13.0, top: 5.0),
                    child: Text(
                      seller.address!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  width: 164.0,
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
                            const Icon(Icons.star, color: Colors.white),
                          ],
                        ),
                      if (rating == 3)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow[700]),
                            Icon(Icons.star, color: Colors.yellow[700]),
                            Icon(Icons.star, color: Colors.yellow[700]),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                          ],
                        ),
                      if (rating == 2)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow[700]),
                            Icon(Icons.star, color: Colors.yellow[700]),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                          ],
                        ),
                      if (rating == 1)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow[700]),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                            const Icon(Icons.star, color: Colors.white),
                          ],
                        ),

                      if (rating == 0)
                        Row(
                          children: const [
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.network(
                  "http://10.0.2.2:/shopice/assets/${seller.image!}", height: 150, width: 140,),
            ),
          ],
        ),
      ),
    );
  }
}
