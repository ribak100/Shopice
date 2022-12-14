import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shopice/server_handler.dart';
import '../models/product.dart';
import '../utility/colors.dart';
import '../models/seller.dart';
import '../screens/product_detail_screen.dart';

class ViewProductItem extends StatefulWidget {
  final Product product;
  final int productIndex;

  const ViewProductItem(
      {Key? key, required this.product, required this.productIndex})
      : super(key: key);

  @override
  State<ViewProductItem> createState() => _ViewProductItemState();
}

class _ViewProductItemState extends State<ViewProductItem> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  bool _validateName = false;
  bool _validatePrice = false;
  bool _validateDescription = false;
  late String response;
  late String responseDelete;

  @override
  Widget build(BuildContext context) { // Used this to generate all list of user product to be view
    int interact;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 19.0, top: 15),
          child: Column(
              //image section

              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Container(
                          height: 150.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: primaryColor[widget.productIndex % 4]
                                    .withOpacity(0.6),
                                width: 3.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 140.0,
                        width: 190.0,
                        margin: const EdgeInsets.only(
                            left: 7.0, right: 0.0, top: 8.0, bottom: .0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: primaryColor[widget.productIndex % 4],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                primaryColor[widget.productIndex % 4],
                                primaryColor[widget.productIndex % 4]
                                    .withOpacity(0.0),
                              ]),
                        ),
                        child: Image.network(
                          "http://10.0.2.2:/shopice/assets/${widget.product.image!}",
                        ),
                      ),
                    ],
                  ),
                ),

                //product name
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Text(
                        widget.product.name!,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff4A777A),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Text(
                        '#' + widget.product.pricePerKg!,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff4A777A),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 200.0,
                  height: 20.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: Text(
                      widget.product.description!,textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            children: [
              FlatButton(
                  onPressed: () => showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 550.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 3.0, bottom: 20.0),
                                  child: TextField(
                                    controller: nameController,
                                    inputFormatters: [],
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Color(0xff4A777A)),
                                      prefixIcon: Icon(Icons.description),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff4A777A)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      errorText: _validateName
                                          ? 'Name Can\'t Be Empty'
                                          : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 3.0),
                                  child: TextField(
                                    controller: priceController,
                                    decoration: InputDecoration(
                                      labelText: 'Price/Kg',
                                      labelStyle:
                                          TextStyle(color: Color(0xff4A777A)),
                                      prefixIcon:
                                          Icon(Icons.price_change_outlined),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff4A777A)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      errorText: _validatePrice
                                          ? 'Email Can\'t Be Empty'
                                          : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 3.0,
                                      right: 3.0),
                                  child: TextField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      labelStyle:
                                          TextStyle(color: Color(0xff4A777A)),
                                      prefixIcon: Icon(Icons.note),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff4A777A)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      errorText: _validateDescription
                                          ? 'Description Can\'t Be Empty'
                                          : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 87.0, right: 40.0),
                                  child: FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                      color: const Color(0xff4A777A),
                                      height: 35.0),
                                ),
                                FlatButton(
                                    onPressed: () async {
                                      response = await ServerHandler()
                                          .editProduct(
                                              widget.product.sellerId!,
                                              widget.product.image!,
                                              nameController.text,
                                              int.parse(priceController.text),
                                              descriptionController.text);
                                      print(response);
                                      setState(() {});
                                      if (response == 'success') {
                                        Navigator.pop(context);
                                        var snackbar = SnackBar(
                                          content: Text('Success!',
                                              style: TextStyle(fontSize: 20.0)),
                                          backgroundColor:
                                              const Color(0xff4A777A),
                                          padding: EdgeInsets.only(left: 50.0),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text('Submit'),
                                    color: const Color(0xffE4DAD9),
                                    height: 35.0),
                              ],
                            ),
                          ),
                        );
                      }),
                  child: Text('Edit'),
                  color: const Color(0xffE6E6F2),
                  height: 70.0),
              SizedBox(
                height: 12.0,
              ),
              FlatButton(
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SizedBox(height: 150.0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text('Do You Really Wanna Delete The Product?', style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,),),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 77.0, right: 40.0, top: 20.0),
                                      child: FlatButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Cancel'),
                                          color: const Color(0xff4A777A),
                                          height: 35.0),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 40.0, top: 20.0),
                                      child: FlatButton(
                                          onPressed: () async{
                                            responseDelete= await ServerHandler().deleteProduct(widget.product.sellerId!, widget.product.image!);
                                            print(responseDelete);

                                            if(responseDelete == 'success'){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              setState(() {

                                              });
                                              var snackbar = SnackBar(content: Text('Deleted!', style: TextStyle(fontSize: 20.0)), backgroundColor: const Color(0xff4A777A), padding: EdgeInsets.only(left: 50.0),);
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);

                                            }
                                          },
                                          child: Text('Delete'),
                                          color: const Color(0xffE4DAD9),
                                          height: 35.0),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );

                        });

                  },
                  child: Text('Delete'),
                  color: const Color(0xffE6F3EC),
                  height: 70.0),
              Padding(padding: EdgeInsets.only(top: 10.0, bottom: 30.0)),
            ],
          ),
        )
      ],
    );
  }
}



