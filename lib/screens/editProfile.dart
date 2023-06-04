import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/editProfile.dart';
import 'package:shopice/server_handler.dart';
import 'package:shopice/widgets/flatButton.dart';



class EditProfile extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  const EditProfile({Key? key, required this.receivedMap}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool _firstExec = false;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController shippingAddressController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController nationalityController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();

  bool _validateName = false;
  bool _validatePhone = false;
  bool _validateAddress = false;
  bool _validateShipping = false;
  bool _validateCountry = false;
  bool _validateNationality = false;



  @override
  Widget build(BuildContext context) {


    if(_firstExec == false){
      nameController.text = widget.receivedMap['name'];
      emailController.text = widget.receivedMap['email'];
      addressController.text = widget.receivedMap['address'];


      if(widget.receivedMap['phone_number'] != null){
        phoneNumberController.text = widget.receivedMap['phone_number'];
        postalCodeController.text = widget.receivedMap['postal_code'];
        shippingAddressController.text = widget.receivedMap['shipping_address'];
        countryController.text = widget.receivedMap['country'];
        nationalityController.text = widget.receivedMap['nationality'];
      }



      _firstExec = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 200.0, left: 20.0, bottom: 30.0),
                child: Row(
                  children: [
                    Container(
                        height: 62.0,
                        width: 62.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}"),
                                fit: BoxFit.fitHeight),
                            shape: BoxShape.circle,
                            color: Colors.grey)
                    ),
                    Text("  ID: ${widget.receivedMap['id']}"),
                  ],
                ),
              ),

              TextField(decoration: InputDecoration(labelText: "Name"), controller: nameController, ),
              TextField(enabled: false,decoration: InputDecoration(labelText: "Email"), controller: emailController, ),
              TextField(decoration: InputDecoration(labelText: "Phone Number"), controller: phoneNumberController,),
              TextField(decoration: InputDecoration(labelText: "Address"), controller: addressController,),
              TextField(decoration: InputDecoration(labelText: "Shipping Address"), controller: shippingAddressController,),
              TextField(decoration: InputDecoration(labelText: "Country"), controller: countryController,),
              TextField(decoration: InputDecoration(labelText: "Nationality"), controller: nationalityController,),
              TextField(decoration: InputDecoration(labelText: "Postal Code"), controller: postalCodeController,),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FlatButton(child: Text("Update", style: TextStyle(color: Colors.white)),onPressed: ()  {
                setState(() {
                  ServerHandler().updateBuyerDetails(int.parse(widget.receivedMap['id']), widget.receivedMap['email'], nameController.text, addressController.text, phoneNumberController.text, countryController.text, nationalityController.text, postalCodeController.text, shippingAddressController.text);

                });
                   var snackBar = SnackBar(content: Text("Detials Updated Successfully.... \nLogout To Reflect Changes"));
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   Navigator.of(context).pop();

                }, color: Color(0xff4A777A),),
              )
            ],),

        ),
      ),
    );
  }
}
