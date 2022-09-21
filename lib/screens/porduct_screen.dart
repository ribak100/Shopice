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
      ),
    );
  }
}
