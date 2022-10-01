import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../server_handler.dart';
import '../models/seller.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product-screen';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> _products = [];

  bool _firstExec = true;

  void getProductsPerSeller(int sellerId) {
    ServerHandler().getProductsPerSeller(sellerId).then((value) => {
          setState(() {
            print(value);
            _products = value;
          })
        });
    //.catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    Seller seller = ModalRoute.of(context)!.settings.arguments as Seller;
    if (_firstExec == true) {
      getProductsPerSeller(seller.id!);
      _firstExec = false;
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35.0,
                    right: 30.0,
                    top: 50.0,
                    bottom: 20.0
                  ),
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
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),

                // Loading widget
                if (_products.isEmpty)
                  Column(
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
                          'Loading Products',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),

                //List of Items

                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: SizedBox(
                    height: 130.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: _products.length,
                        itemBuilder: (context, index) => ProductItem(product: _products[index], productIndex: index,),),
                  ),
                ),


              ],
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

            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: SizedBox(
                height: 130.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  itemBuilder: (context, index) => ProductItem(product: _products[index], productIndex: index,),),
              ),
            ),

        Padding(
          padding: const EdgeInsets.only(right: 80.0, top: 10.0),
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
              padding:
              const EdgeInsets.only(left: 20.0, right: 20.0,),
              child: Column(
                children: [
                  SizedBox(
                    height: 80.0,
                    /*child: Text(
                      product.description!,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),*/
                  ),
                  Container(
                      //margin: EdgeInsets.only(top: 15.0),
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
                ],
              ),
            ),

            //icons below  the screen
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(top: 42.0),
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
    );
  }
}
