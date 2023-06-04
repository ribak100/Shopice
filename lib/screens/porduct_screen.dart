import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../buttomNavBar/home.dart';
import '../buttomNavBar/search.dart';
import '../server_handler.dart';
import '../models/seller.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import '../widgets/most_popular.dart';
import '../screens/cart.dart';
import '../screens/profile.dart';

// TODO: implement the function to auto login(maybe using shared preferences and add animation to the drawer


class ProductScreen extends StatefulWidget {
  // static const routeName = '/product-screen';
  final Seller seller;
   final Map<String, dynamic> receivedMap;

  const ProductScreen({Key? key, required this.seller, required this.receivedMap}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> _products = [];
  late int interact;
  final int rating = 4;
  bool _firstExec = true;
  var cartErrorSnackBar = const SnackBar(content: Text("Login to view Cart!"));

  void getProductsPerSeller(int sellerId) {
    ServerHandler().getProductsPerSeller(sellerId).then((value) => {
          setState(() {
            _products = value;
          })
        });
    //.catchError((e) => print(e));
  }


  final PageController _pageController = PageController();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showUnavailable() {
    var snackBar = const SnackBar(content: Text("Available Soon!"));

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as ProductScreenArguments;

    if (_firstExec == true) {
      getProductsPerSeller(widget.seller.id!);
      _firstExec = false;
    }
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: PageView(
          controller: _pageController,
          children: [
            Home( products: _products, seller: widget.seller, receivedMap: widget.receivedMap,),
            Search(
              data: _products,
              receivedMap: widget.receivedMap,
              seller: widget.seller,
            ),
            widget.receivedMap['name'] == null
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xff4E8489),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        'Login to view Cart Items',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                : Cart(receivedMap: widget.receivedMap, seller: widget.seller),
            widget.receivedMap['name'] == null
                ? Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Color(0xff4E8489),
                borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50), bottomLeft: Radius.circular(50) ),
              ),
              child: const Center(
                child: Text(
                  'Login to view Profile Items',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
                :Profile(receivedMap: widget.receivedMap),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(CupertinoIcons.cart),
          Icon(CupertinoIcons.person),
        ],
        backgroundColor: Color(0xff4E8489),
        color: Colors.white,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 500),
      ),
    );
  }
}
