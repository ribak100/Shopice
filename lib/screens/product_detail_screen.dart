import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:shopice/widgets/product_item.dart';
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
              style: GoogleFonts.inter(),
            ),
          ),
          backgroundColor: const Color(0xff4A777A),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
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
                Container(
                    padding: EdgeInsets.only(left: 40.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '#${product.pricePerKg!} /kg',
                      style: GoogleFonts.poppins(color: Color(0xff4A777A), fontSize: 25.0, fontWeight: FontWeight.w500),
                    )),
                //product price per kh
              ],
            ),
          ),
        ));
  }
}
