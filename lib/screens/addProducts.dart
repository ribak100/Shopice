import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../models/seller.dart';
import '../utility/removeBg.dart';
import '../screens/viewProducts.dart';
import '../screens/availableOrder.dart';
import '../screens/shippedOrder.dart';
import '../screens/completedOrder.dart';

class AddProduct extends StatefulWidget {
  //static const routeName = '/addProduct-screen';
  final Map<String, dynamic> receivedMap;



   const AddProduct({Key? key, required this.receivedMap}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  bool _validateName = false;
  bool _validatePrice = false;
  bool _validateDescription = false;



  Future ChoiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future UploadImage() async {
  //File file = File(_image!.path);
    final uri = Uri.parse("http://10.0.2.2:/shopice/api/seller/add");
    var request = http.MultipartRequest('POST', uri);
    request.fields['seller_id'] = widget.receivedMap['id'];
    request.fields['name'] = nameController.text;
    request.fields['price_per_kg'] = priceController.text;
    request.fields['description'] = descriptionController.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();


    if (response.statusCode == 200) {
      showModalBottomSheet(context: context, builder: (context){
        return Wrap(children: [ListTile(leading: Icon(Icons.done_outline), title: Text('PRODUCT UPLOADED SUCCESSFULLY'),)],);
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
    var mapResponse = Map<String, dynamic>();
    mapResponse['name'] = widget.receivedMap['name'];
    mapResponse['email'] = widget.receivedMap['email'];
    mapResponse['image'] = widget.receivedMap['image'];
    mapResponse['id'] = widget.receivedMap['id'];
    mapResponse['address'] = widget.receivedMap['address'];
    mapResponse['description'] = widget.receivedMap['description'];

    return Scaffold(
      backgroundColor: Color(0xffE6F3EC),
      appBar: AppBar(
        title: Text(
          "Shopice",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 23.0,
            color: Color(0xff4E8489),
          ),
        ),
        backgroundColor: Color(0xffE6F3EC),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
               child: Column(
                 children: [
                   Container(
                      height: 102.0,
                      width: 102.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}"),
                              fit: BoxFit.fitHeight),
                          shape: BoxShape.circle,
                          color: Colors.grey),
                    ),
                   Text(widget.receivedMap['name'], style: GoogleFonts.poppins(
                     fontWeight: FontWeight.w500,
                     fontSize: 17.0,
                     color: Colors.black,
                   ),),
                 ],
               ),
            ),

            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.receivedMap['description'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              onTap: () => print('login'), //Navigator.of(context).popAndPushNamed(Registration_seller.routeName),
              minLeadingWidth: 20.0,
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text(
                "Add New Product",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.pop(context),
              minLeadingWidth: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text(
                "View All Products",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),

              onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewProduct(receivedMap: mapResponse,))),
              minLeadingWidth: 20.0,
            ),

             ListTile(
              leading: Icon(Icons.shopping_cart_checkout),
              title: Text(
                "Available Orders",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AvailableOrder(receivedMap: mapResponse,))),
              minLeadingWidth: 20.0,
            ),

            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text(
                "Shipped Products",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShippedOrder(receivedMap: mapResponse,))),
              minLeadingWidth: 20.0,
            ),

            ListTile(
              leading: Icon(Icons.library_add_check),
              title: Text(
                "Completed Orders",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompletedOrder(receivedMap: mapResponse,))),
              minLeadingWidth: 20.0,
            ),

            ListTile(
              leading: Icon(Icons.close),
              title: Text(
                "Exit",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
              minLeadingWidth: 20.0,
            ),
          ],
        ),
      ),
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
              const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 20.0),
              child: TextField(
                controller: nameController,inputFormatters: [],
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Color(0xff4A777A)),
                  prefixIcon: Icon(Icons.description),
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
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price/Kg',
                  labelStyle: TextStyle(color: Color(0xff4A777A)),
                  prefixIcon: Icon(Icons.price_change_outlined),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4A777A)),
                      borderRadius: BorderRadius.circular(20)),
                  errorText: _validatePrice ? 'Email Can\'t Be Empty' : null,
                ),
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
                onPressed: () async{
                  setState(() {
                    nameController.text.isEmpty
                        ? _validateName = true
                        : _validateName = false;
                    priceController.text.isEmpty ? _validatePrice= true : _validatePrice = false;
                    descriptionController.text.isEmpty ? _validateDescription = true : _validateDescription = false;

                  });

                  if(_image == null){
                    showModalBottomSheet(context: context, builder: (context){
                      return Wrap(children: [ListTile(leading: Icon(Icons.error), title: Text('Image Can\'t Be Empty'),)],);
                    });
                    return;
                  }
                  UploadImage();
                  Future.delayed(const Duration(seconds: 2), (){
                    Navigator.of(context).pop();

                  });

                },
                color: Color(0xff4A777A),
                child: Text(
                  "Add Product",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
