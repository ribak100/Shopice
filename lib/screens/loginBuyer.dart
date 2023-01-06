import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/seller.dart';
import '../screens/splash_screen.dart';
import '../screens/addProducts.dart';
import '../screens/Login.dart';

class LoginBuyer extends StatefulWidget {
  static const routeName = '/LoginBuyer-screen';

  LoginBuyer({Key? key}) : super(key: key);

  @override
  State<LoginBuyer> createState() => _LoginBuyerState();
}

class _LoginBuyerState extends State<LoginBuyer> {
  TextEditingController emailController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  var map = Map<String, dynamic>();

  var mapResponseLoginBuyer = Map<String, dynamic>();

  var jsonResponse;

  bool _validateEmail = false;

  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6F3EC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  child: Icon(
                    Icons.person_outline,
                    size: 90.0,
                  ),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 5.0, bottom: 40.0, left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Shopice",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 23.0,
                      color: Color(0xff4E8489),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 170.0),
                    child: Text(
                      "Switch",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: PopupMenuButton(onSelected: (value) => {
                      if(value == 1){
                        Navigator.of(context).popAndPushNamed(
                            Login.routeName),
                      }
                      else if(value == 2){
                        Navigator.of(context).popAndPushNamed(LoginBuyer.routeName),
                      }
                    },itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Seller"),
                        value: 1,


                      ),
                      PopupMenuItem(
                        child: Text("Buyer"),
                        value: 2,
                        enabled: false,
                      ),
                    ]),
                  ),
                ],
              ),


            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _validateEmail ? "'Email Can\'t Be Empty'": null,
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 30.0, left: 3.0, right: 3.0),
              child: TextField(obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _validatePassword ? "Password Cant\'t Be Empty" : null,
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                setState(() {

                  emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                  passwordController.text.isEmpty ? _validatePassword = true : _validatePassword = false;
                });

                map['email'] = emailController.text;
                map['password'] = passwordController.text;
                final response = await http.post(
                  Uri.parse('http://10.0.2.2://shopice/api/buyer/login'), body: map,
                );
                // showModalBottomSheet(
                //     context: context,
                //     builder: (context) {
                //       return Text(response.body);
                //     });

                if (response.statusCode == 200) {
                  jsonResponse = jsonDecode(response.body)['buyer'];

                  mapResponseLoginBuyer['name'] = jsonResponse['name'];
                  mapResponseLoginBuyer['email'] = jsonResponse['email'];
                  mapResponseLoginBuyer['image'] = jsonResponse['image'];
                  mapResponseLoginBuyer['id'] = jsonResponse['id'];
                  mapResponseLoginBuyer['address'] = jsonResponse['address'];
                  mapResponseLoginBuyer['phone_number'] = jsonResponse['phone_number'];
                  mapResponseLoginBuyer['postal_code'] = jsonResponse['postal_code'];
                  mapResponseLoginBuyer['shipping_address'] = jsonResponse['shipping_address'];
                  mapResponseLoginBuyer['country'] = jsonResponse['country'];
                  mapResponseLoginBuyer['nationality'] = jsonResponse['nationality'];


                  print(response.body);
                  var snackbar = SnackBar(
                    content: Text('Login Successful!',
                        style: TextStyle(fontSize: 20.0)),
                    backgroundColor:
                    const Color(0xff4A777A),
                    padding: EdgeInsets.only(left: 50.0),
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackbar);
                  Future.delayed(Duration(seconds: 4));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashScreen(receivedMap: mapResponseLoginBuyer,)));
                }

              },
              color: Color(0xff4A777A),
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
