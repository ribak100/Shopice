import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/seller.dart';
import '../widgets/seller_item.dart';

class SellersScreen extends StatefulWidget {
  static const routeName = '/sellers_screen';

  const SellersScreen({Key? key}) : super(key: key);

  @override
  State<SellersScreen> createState() => _SellersScreenState();
}

class _SellersScreenState extends State<SellersScreen> {
  List<Color> sellerItemBackgroundColor = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellerItemBackgroundColor.add(const Color(0xffE6F3EC));
    sellerItemBackgroundColor.add(const Color(0xffE6E6F2));
    sellerItemBackgroundColor.add(const Color(0xffE4EDF4));
    sellerItemBackgroundColor.add(const Color(0xffE4DAD9));
  }

  @override
  Widget build(BuildContext context) {
    List<Seller> sellers =
        ModalRoute.of(context)?.settings.arguments as List<Seller>;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 50.0,
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

            //list of sellers
            Column(
              children: sellers
                  .map((e) => SellerItem(
                        seller: e,
                        backgroundColor: sellerItemBackgroundColor[sellers.indexOf(e)%4],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    ));
  }
}
