import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/payment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shopice/widgets/flatButton.dart';

import '../server_handler.dart';
import '../screens/sellers_screen.dart';
import '../models/seller.dart';
import '../screens/porduct_screen.dart';

class PaymentScreenArguments {
  final Map<String, dynamic> receivedMap;
  final int totalPrice;
  final Seller seller;

  PaymentScreenArguments(this.totalPrice, this.receivedMap, this.seller);
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/payment-screen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  bool _firstexec = false;
  bool showLoadingSellers = true;
  bool isChecked = false;
  String dropDownValue = 'Choose Payment Method';
  File? _image;
  bool paymentBoxVisible = false;
  bool bankTransferVisible = false;
  bool cardPyamentVisible = false;
  bool payOnDeliveryVisible = false;
  bool coverUpVisible = true;
  bool payButtonVisible = false;
  final picker = ImagePicker();
  var items = [
    'Choose Payment Method',
    'Bank Transfer',
    'Card Payment',
    'Payment On Delivery',
  ];

  String ShippingValue = 'Select Shipping Address';

  var address = [
    'Select Shipping Address',
    'agun opp samani off kwara state',
    'ile magaji offa',
  ];


  Future ChoiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    showLoadingSellers = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as PaymentScreenArguments;

    if (_firstexec == false) {
      setState(() {
        Future.delayed(Duration(seconds: 2));
        showLoadingSellers = false;
      });
      _firstexec = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          color: const Color(0xffE6F3EC),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text(
                  'Payment Page',
                  style: GoogleFonts.pacifico(
                      color: const Color(0xff4E8489), fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(width: 210.0,
                  child: DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {

                        setState(() {
                          ShippingValue = 'Select Shipping Address';
                          dropDownValue = newValue!;
                          if(dropDownValue == 'Choose Payment Method'){
                            paymentBoxVisible = false;
                            coverUpVisible = true;
                          }
                          else{
                            paymentBoxVisible = true;
                          }


                        });
                      }),
                ),
              ),

              Visibility(
                visible: paymentBoxVisible,
                child: SizedBox(width: 230.0,
                  child: DropdownButton(
                      value: ShippingValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(overflow: TextOverflow.clip, color: Colors.black, ),
                      items: address.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          ShippingValue = newValue!;
                        });
                        if(dropDownValue != 'Choose Payment Method'){
                        if(ShippingValue != 'Select Shipping Address'){
                          if(dropDownValue == 'Bank Transfer'){
                            setState(() {
                              bankTransferVisible = true;
                              cardPyamentVisible = false;
                              payOnDeliveryVisible = false;
                              coverUpVisible = false;
                            });
                          }
                          else{
                            setState(() {
                              bankTransferVisible = false;
                            });
                          }

                            if(dropDownValue == 'Card Payment'){
                              setState(() {
                                cardPyamentVisible = true;
                                bankTransferVisible = false;
                                payOnDeliveryVisible = false;
                                coverUpVisible = false;
                              });

                          }
                          else{
                              setState(() {
                                cardPyamentVisible = false;
                              });

                            }
                            if(dropDownValue == 'Payment On Delivery'){
                              setState(() {
                                payOnDeliveryVisible = true;
                                cardPyamentVisible = false;
                                bankTransferVisible = false;
                                coverUpVisible = false;
                              });

                          }
                            else{
                              setState(() {
                                payOnDeliveryVisible = false;
                              });
                            }

                            if((dropDownValue != 'Bank Transfer')&&(dropDownValue != 'Card Payment')&&(dropDownValue != 'Payment On Delivery')){
                              setState(() {
                                coverUpVisible = true;
                              });
                            }
                        }else{
                          var snackbar = SnackBar(content: Text("Select a Address"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }

                        }else{
                          var snackbar = SnackBar(content: Text("Select a Payment Method"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }

                      }),
                ),
              ),

        Visibility(visible: coverUpVisible,child: Container(color: const Color(0xffE6F3EC), height: 2000)),

        Visibility(
          visible: bankTransferVisible,
          child: Column(
            children: [

              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),),height: 110.0, width: 200.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("\nAccount Details \nAccount Name :- Cyrex ltd\nAccount Number :- 0234108737\nBank :- GTBank\n"),
                ),
              ),

              _image == null ?
              Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey,border: Border.all(color: const Color(0xff4E8489))),height: 170.0, width: 200.0,

                  )
              ) : Padding(
                padding:  const EdgeInsets.only(top: 30.0, bottom: 5.0),
                child: Image.file(_image!, height: 170.0, width: 200.0,),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState((){
                    ChoiceImage();
                  });
                },
                icon: Icon(Icons.photo),
                label: Text('Upload Slip'),
                style:
                ElevatedButton.styleFrom(primary: Color(0x9f4A777A)),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                child: Text(textAlign: TextAlign.center,
                  "  Total(#${args.totalPrice})",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: const Color(0x9f000000),
                  ),
                ),
              ),

              Visibility( visible: payButtonVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: FlatButton(
                    onPressed: () async{
                      await ServerHandler().payment(args.seller.id!, int.parse(args.receivedMap['id']), "paid");
                      ServerHandler().deleteCartProduct(int.parse(args.receivedMap['id']), args.receivedMap['name']);


                      var snackbar = SnackBar(content: Text("Payment Successful!"));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackbar);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                    },
                    color:Color(0xff4E8489) ,child: Text(textAlign: TextAlign.center,
                      "Submit",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                        color: const Color(0xffffffff),
                      ),),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[300],border: Border.all(color: Colors.grey)),height: 60.0, width: 255.0,
                  child: Center(child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: Checkbox(value: isChecked, onChanged: (value)
                        {
                          setState(() {
                            isChecked = value!;
                            if(isChecked == true){
                              payButtonVisible = true;
                            }
                            else{
                              payButtonVisible = false;
                            }

                          });
                        }),
                      ),
                      Text("By clicking Pay you have agreed \nto our Terms and Conditions!"),
                    ],
                  )),


                ),
              ),

            ],),
        ),




              Visibility(
                visible: cardPyamentVisible,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),),height: 250.0, width: 300.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Card Number',
                                    labelStyle: TextStyle(color: Color(0xff4A777A)),
                                    prefixIcon: Icon(Icons.credit_card),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff4A777A)),
                                        borderRadius: BorderRadius.circular(00)) ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: SizedBox(height: 50, width: 150,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: 'Expire Date',
                                            labelStyle: TextStyle(color: Color(0xff4A777A)),
                                            prefixIcon: Icon(Icons.credit_card),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xff4A777A)),
                                                borderRadius: BorderRadius.circular(00)) ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 50, width: 120,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: 'CVV',
                                          labelStyle: TextStyle(color: Color(0xff4A777A)),
                                          prefixIcon: Icon(Icons.credit_card),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff4A777A)),
                                              borderRadius: BorderRadius.circular(00)) ),
                                    ),
                                  ),
                                ],
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                      child: Text(textAlign: TextAlign.center,
                        "  Total(#${args.totalPrice})",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          color: const Color(0x9f000000),
                        ),
                      ),
                    ),

                    Visibility( visible: payButtonVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: FlatButton(
                          onPressed: () => print('Pay Clicked'),
                          color:Color(0xff4E8489) ,child: Text(textAlign: TextAlign.center,
                          "Pay",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            color: const Color(0xffffffff),
                          ),),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[300],border: Border.all(color: Colors.grey)),height: 60.0, width: 255.0,
                        child: Center(child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7.0),
                              child: Checkbox(value: isChecked, onChanged: (value)
                              {
                                setState(() {
                                  isChecked = value!;
                                  if(isChecked == true){
                                    payButtonVisible = true;
                                  }
                                  else{
                                    payButtonVisible = false;
                                  }

                                });
                              }),
                            ),
                            Text("By clicking Pay you have agreed \nto our Terms and Conditions!"),
                          ],
                        )),


                      ),
                    ),

                    SizedBox(height: 60.0,)
                  ],),
              ),


              Visibility(
                visible: payOnDeliveryVisible,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),),height: 110.0, width: 200.0,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 30.0, top: 30.0),
                          child: Column(
                            children: const [
                              Text("Payment On Delivery is Unavailable Currently"),
                              Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: Icon(Icons.disabled_by_default),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 50),
                      child: Text(textAlign: TextAlign.center,
                        "  Total(#${args.totalPrice})",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                          color: const Color(0x9f000000),
                        ),
                      ),
                    ),



                    SizedBox(height: 500.0,)
                  ],),
              ),


    ],
          ),


        ),
      ),
    );


  }
}

