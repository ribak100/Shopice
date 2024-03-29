import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopice/widgets/flatButton.dart';

import '../models/seller.dart';
import '../screens/addProducts.dart';
import '../screens/loginBuyer.dart';

class Login extends StatelessWidget {
  static const routeName = '/login-screen';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var map = Map<String, dynamic>();
  var mapResponseLogin = Map<String, dynamic>();
  var jsonResponse;

  Login({Key? key}) : super(key: key);

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
                        enabled: false,

                      ),
                      PopupMenuItem(
                        child: Text("Buyer"),
                        value: 2,

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
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            FlatButton(
              height: 35,
              onPressed: () async {
                 map['email'] = emailController.text;
                 map['password'] = passwordController.text;
                final response = await http.post(
                  Uri.parse('http://10.0.2.2://shopice/api/seller/login'), body: map,
                );


                if (response.statusCode == 200) {
                   jsonResponse = jsonDecode(response.body)['seller'];

                   mapResponseLogin['name'] = jsonResponse['name'];
                   mapResponseLogin['email'] = jsonResponse['email'];
                   mapResponseLogin['image'] = jsonResponse['image'];
                   mapResponseLogin['id'] = jsonResponse['id'];
                   mapResponseLogin['address'] = jsonResponse['address'];
                   mapResponseLogin['description'] = jsonResponse['description'];

                  print( mapResponseLogin['name']);
                  print(response.body);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProduct(receivedMap: mapResponseLogin,)));
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
