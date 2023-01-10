import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/seller.dart';
import '../models/product.dart';
import '../screens/cart.dart';
import '../screens/profile.dart';


class DetailProduct {
  late final Product product;
  late final Seller seller;
  final Map<String, dynamic> receivedMap;

  DetailProduct(this.product, this.seller, this.receivedMap);
}

class ProductScreenDetails extends StatefulWidget {
  static const routeName = '/product-detaail-screen';

  const ProductScreenDetails({Key? key}) : super(key: key);

  @override
  State<ProductScreenDetails> createState() => _ProductScreenDetailsState();
}

class _ProductScreenDetailsState extends State<ProductScreenDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailProduct;

    int rating = 4;

    return Scaffold(
        //Appbar
        appBar: AppBar(
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(left: 85.0),
            child: Text(
              args.product.name!,
              style: GoogleFonts.poppins(),
            ),
          ),
          backgroundColor: const Color(0xff4A777A),
          leading: GestureDetector(
            onTap: () => {
              Navigator.of(context).pop(),
            },
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
                  child: Hero(
                    tag: "popular.${args.product.image!}",
                    child: Image.network(
                      "http://10.0.2.2:/shopice/assets/${args.product.image!}",
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                //product price per kh
                Container(
                    padding: EdgeInsets.only(left: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '#${args.product.pricePerKg!}/kg',
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
                        height: 110.0,
                        child: Text(
                          args.product.description!,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),

                      //comment and description box
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0.0,
                          right: 00.0,
                          bottom: 25.0,
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
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 30.0, top: 3.0),
                                              height: 35.0,
                                              width: 35.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "http://10.0.2.2:/shopice/assets/${args.seller.image}"),
                                                      fit: BoxFit.fitWidth),
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 0.0,
                                                  top: 5.0),
                                              child: Text(args.seller.name!,
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xff4E8489),
                                                    fontSize: 13,
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
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
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                        ],
                                                      ),
                                                    if (rating == 4)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    if (rating == 3)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    if (rating == 2)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    if (rating == 1)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700]),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    if (rating == 0)
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.white),
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
                                          child: Text(
                                              args.seller.description as String,
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
                                  onPressed: ()
                                      {
                                  var snackBar = SnackBar(content: Text("Will be available soon... please add to cart instead!"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                  child: Text(
                                    'Buy Now',
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
                                  onPressed: () async {
                                    if (args.receivedMap['id'] != null) {
                                      final uri = Uri.parse(
                                          "http://10.0.2.2:/shopice/api/buyer/addToCart");
                                      var request =
                                          http.MultipartRequest('POST', uri);
                                      request.fields['buyer_id'] =
                                          args.receivedMap['id'];
                                      request.fields['seller_id'] =
                                          args.seller.id.toString();
                                      request.fields['seller_name'] =
                                          args.seller.name!;
                                      request.fields['buyer_name'] =
                                          args.receivedMap['name'];
                                      request.fields['price'] =
                                          args.product.pricePerKg!;
                                      request.fields['product_name'] =
                                          args.product.name!;
                                      request.fields['image'] =
                                          args.product.image!.toString();

                                      var response = await request.send();
                                      print(args.product.image);

                                      if (response.statusCode == 200) {
                                        var snackbar = SnackBar(
                                          content: Text(
                                              'Product Added To Cart!',
                                              style: TextStyle(fontSize: 20.0)),
                                          backgroundColor:
                                              const Color(0xff4A777A),
                                          padding: EdgeInsets.only(left: 50.0),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      } else if (response.statusCode == 500) {
                                        var snackbar = SnackBar(
                                          content: Text('Server Error!',
                                              style: TextStyle(fontSize: 20.0)),
                                          backgroundColor:
                                              const Color(0xff4A777A),
                                          padding: EdgeInsets.only(left: 50.0),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      } else {
                                        var snackbar = SnackBar(
                                          content: Text(
                                              'ERROR WHILE PERFORMING OPPERATION\n CONTACT SUPPORT!',
                                              style: TextStyle(fontSize: 20.0)),
                                          backgroundColor:
                                              const Color(0xff4A777A),
                                          padding: EdgeInsets.only(left: 50.0),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    } else if (args.receivedMap['id'] == null) {
                                      var snackbar = SnackBar(
                                        content: Text(
                                            'Login To Add Product To Cart!',
                                            style: TextStyle(fontSize: 16.0)),
                                        backgroundColor:
                                            const Color(0xff4A777A),
                                        padding: EdgeInsets.only(left: 50.0),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    }
                                  },
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
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          icon: Icon((Icons.home))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.search))),
                      IconButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/cart-screen',
                              arguments: CartArguments(args.receivedMap, args.seller)
                                  as CartArguments),
                          icon: Icon((Icons.shopping_cart_sharp))),
                      IconButton(
                          onPressed: () => print('Icon buton pressed'),
                          icon: Icon((Icons.menu))),
                      IconButton(
                          onPressed: () => Navigator
                              .pushNamed(context, '/profile-screen', arguments: ProfileScreenArguments(args.receivedMap
                          )as ProfileScreenArguments
                          ),

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
