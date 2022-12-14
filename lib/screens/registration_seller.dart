import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../screens/login.dart';
import '../screens/registration_buyer.dart';

class Registration_seller extends StatefulWidget {
  static const routeName = '/register-screen';

  const Registration_seller({Key? key}) : super(key: key);

  @override
  State<Registration_seller> createState() => _Registration_sellerState();
}

class _Registration_sellerState extends State<Registration_seller> {
  List<bool> _selections = List.generate(2, (_)=>false );
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateAddress = false;
  bool _validateDescription = false;

  Future ChoiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future UploadImage() async {
    final uri = Uri.parse("http://10.0.2.2:/shopice/api/seller/register");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['address'] = addressController.text;
    request.fields['description'] = descriptionController.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      showModalBottomSheet(context: context, builder: (context){
        return Wrap(children: [ListTile(leading: Icon(Icons.done_outline), title: Text('SELLER REGISTERED SUCCESSFULLY'),)],);
      });
    }
    else if (response.statusCode == 401) {
      showModalBottomSheet(context: context, builder: (context){
        return Wrap(children: [ListTile(leading: Icon(Icons.done_outline), title: Text('BUYER ALREADY EXISTS '),)],);
      });
    }
    else {
      showModalBottomSheet(context: context, builder: (context){
        return Wrap(children: [ListTile(leading: Icon(Icons.done_outline), title: Text('ERROR WHILE PERFORMING OPPERATION\n CONTACT SUPPORT'),)],);
      });
    }
    }


  setStatus(String message) {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    super.dispose();
  }

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
                             Registration_seller.routeName),
                       }
                       else if(value == 2){
                           Navigator.of(context).popAndPushNamed(Registration_buyer.routeName
                               ),
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
              padding:
                  const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 20.0),
              child: TextField(
                controller: nameController,inputFormatters: [],
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Color(0xff4A777A)),
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4A777A)),
                      borderRadius: BorderRadius.circular(20)),
                  errorText: _validateName ? 'Name Can\'t Be Empty' : null,
                ),
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
                      borderRadius: BorderRadius.circular(20)),
                  errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 3.0, right: 3.0),
              child: TextField(
                controller: passwordController,obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20)), errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 3.0, right: 3.0),
              child: TextField(
                controller: confirmPasswordController, obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Confirm',
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 3.0, right: 3.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.share_location_outlined),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20)), errorText: _validateAddress ? 'Address Can\'t Be Empty' : null,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 3.0, right: 3.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                    prefixIcon: Icon(Icons.note),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff4A777A)),
                        borderRadius: BorderRadius.circular(20)), errorText: _validateDescription ? 'Description Can\'t Be Empty' : null,),
              ),
            ),
            Container(
              height: 150.0,
              width: 250.0,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff4A777A),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: _image == null
                  ? ElevatedButton.icon(
                      onPressed: () {
                        ChoiceImage();
                      },
                      icon: Icon(Icons.file_upload_sharp),
                      label: Text('Upload Image'), 
                      style:
                          ElevatedButton.styleFrom(primary: Color(0x9f4A777A)),
                    )
                  : Image.file(_image!),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: RaisedButton(
                shape: BeveledRectangleBorder(),
                elevation: 10.0,
                onPressed: () {
                  setState(() {
                    nameController.text.isEmpty
                        ? _validateName = true
                        : _validateName = false;
                    emailController.text.isEmpty ? _validateEmail= true : _validateEmail = false;
                    passwordController.text.isEmpty ? _validatePassword= true : _validatePassword = false;
                    addressController.text.isEmpty ? _validateAddress= true : _validateAddress = false;
                    descriptionController.text.isEmpty ? _validateDescription = true : _validateDescription = false;

                  });

                  if(passwordController.text != confirmPasswordController.text){
                    showModalBottomSheet(context: context, builder: (context){
                      return Wrap(children: [ListTile(leading: Icon(Icons.error), title: Text('Password Does\'t match'),)],);
                    });
                    return;
                  }
                  if(_image == null){
                    showModalBottomSheet(context: context, builder: (context){
                      return Wrap(children: [ListTile(leading: Icon(Icons.error), title: Text('Image Can\'t Be Empty'),)],);
                    });
                    return;
                  }
                  UploadImage();
                  Future.delayed(const Duration(seconds: 2), (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });

                },
                color: Color(0xff4A777A),
                child: Text(
                  "Register",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(bottom: 20.0, left: 40.0, right: 40.0),
               child: Row(
                 children: [

                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
            ),
                   TextButton(onPressed: () => Navigator.of(context).pushNamed(Login.routeName), child: Text("Login", style: GoogleFonts.poppins(
                     fontWeight: FontWeight.w300,
                     fontSize: 16.0,
                     color:  Color(0xff4A777A),
                   ),),)
                 ],
               ),
             ),

          ],
        ),
      ),
    );
  }
}
