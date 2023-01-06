import 'package:flutter/material.dart';
import 'package:shopice/screens/cart.dart';

import './screens/splash_screen.dart';
import './screens/sellers_screen.dart';
import './screens/porduct_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/login.dart';
import './screens/registration_seller.dart';
import './screens/payment.dart';
import './screens/registration_buyer.dart';
import './screens/loginBuyer.dart';
import './screens/profile.dart';
import './screens/about.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(receivedMap: {},),

      routes: {
        SellersScreen.routeName: (_) => const SellersScreen(),
        ProductScreen.routeName: (_) => const ProductScreen(),
        ProductScreenDetails.routeName: (_) => const ProductScreenDetails(),
        Login.routeName: (_) =>  Login(),
        LoginBuyer.routeName: (_) =>  LoginBuyer(),
        Registration_seller.routeName: (_) => const Registration_seller(),
        Registration_buyer.routeName: (_) => const Registration_buyer(),
        Cart.routeName: (_) => const Cart(),
        PaymentScreen.routeName: (_) => const PaymentScreen(),
        Profile.routeName: (_) => const Profile(),
        About.routeName: (_) => const About(),
        //ViewProduct.routeName: (_) => const ViewProduct(),

       // AddProduct.routeName: (_) => const AddProduct(),



      },
    );
  }
}
