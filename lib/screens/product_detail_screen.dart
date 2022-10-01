import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:shopice/widgets/product_item.dart';
import '../models/seller.dart';
import '../models/product.dart';

class ProductScreenDetails extends StatelessWidget {
  static const routeName = '/product-detaail-screen';

  const ProductScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        //Appbar
        appBar: AppBar(
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(left: 85.0),
            child: Text(
              product.name!,
              style: GoogleFonts.poppins(),
            ),
          ),
          backgroundColor: const Color(0xff4A777A),
          leading: GestureDetector(
            onTap: () =>{ Navigator.of(context).pop(), product.interactionCount = (product.interactionCount! +1)!},
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          // for backgrounf color
          color: Color(0xff4A777A),
          child: Container(
            //main container
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            child: Column(
              children: [
                //product image
                Container(
                  alignment: Alignment.center,
                  child: Image.network(
                    "http://10.0.2.2:/shopice/assets/${product.image!}",
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    alignment: Alignment.center,
                  ),
                ),
                //product price per kh
                Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '#${product.pricePerKg!}/kg',
                      style: GoogleFonts.poppins(
                          color: Color(0xff4A777A),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500),
                    )),
                //Product description
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120.0,
                        child: Text(
                          product.description!,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15.0),
                          height: 100,
                          width: 350.0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE9E6E6),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      //Text(),
                                    ],
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30.0, top: 5.0),
                              height: 36,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: Color(0xff4A777A),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Color(0xff4A777A))),
                              child: FlatButton(
                                  onPressed: () => print('Flat buton pressed'),
                                  child: Text(
                                    'Buy Now'+ product.interactionCount.toString()!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              height: 36,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Color(0xff4A777A))),
                              child: FlatButton(
                                  onPressed: () => print(
                                        'Flat buton pressed',
                                      ),
                                  child: Text(
                                    'Add to Cart',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff4A777A)),
                                  )),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  margin: EdgeInsets.only(top: 23.0),
                  decoration: BoxDecoration(color: Color(0xffF0F0F0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.home))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.search))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.shopping_cart_sharp))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.menu))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.person_outline))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
