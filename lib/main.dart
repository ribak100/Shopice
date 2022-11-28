import 'package:flutter/material.dart';

import './screens/splash_screen.dart';
import './screens/sellers_screen.dart';
import './screens/porduct_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/login.dart';
import './screens/registration_seller.dart';
import './screens/addProducts.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),

      routes: {
        SellersScreen.routeName: (_) => const SellersScreen(),
        ProductScreen.routeName: (_) => const ProductScreen(),
        ProductScreenDetails.routeName: (_) => const ProductScreenDetails(),
        Login.routeName: (_) =>  Login(),
        Registration_seller.routeName: (_) => const Registration_seller(),
       // AddProduct.routeName: (_) => const AddProduct(),



      },
    );
  }
}
