import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/server_handler.dart';



class ChangePassword extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  const ChangePassword({Key? key, required this.receivedMap}) : super(key: key);


  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool _firstExec = false;


  TextEditingController oldController = new TextEditingController();
  TextEditingController newController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();


  bool _validateoldController = false;
  bool _validatenewController = false;
  bool _validateconfirmController = false;



  @override
  Widget build(BuildContext context) {


    if(_firstExec == false){


      _firstExec = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 140.0, left: 20.0, bottom: 30.0),
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
                    Text("    ${widget.receivedMap['name']}"),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20.0, right: 10.0),
                child: TextField(decoration: InputDecoration(labelText: "Old Password",enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4A777A)),
                    borderRadius: BorderRadius.circular(20)), errorText: _validateoldController ? "\nOld Password Is Required!" : null), controller: oldController, ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
                child: TextField(decoration: InputDecoration(labelText: "New Password",labelStyle: TextStyle(color: Color(0xff4A777A)),enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4A777A)),
                    borderRadius: BorderRadius.circular(20)), errorText: _validatenewController ? "\New Password Is Required!" : null), controller: newController,),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
                child: TextField(decoration: InputDecoration(labelText: "Confirm Password",enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4A777A)),
                    borderRadius: BorderRadius.circular(20)), errorText: _validateconfirmController ? "\nCan't Be Empty!" : null), controller: confirmController,),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(child: Text("Change", style: TextStyle(color: Colors.white)),onPressed: ()  async{

                  setState(() {
                    oldController.text.isEmpty ? _validateoldController = true : _validateoldController = false;
                    newController.text.isEmpty ? _validatenewController = true : _validatenewController = false;
                    confirmController.text.isEmpty ? _validateconfirmController = true : _validateconfirmController = false;



                  });


                    if(newController.text == oldController.text){
                      var snackBar = SnackBar(content: Text('New Password Can\'t Be Same With Old '));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;

                    }else{
                      if(newController.text != confirmController.text){
                        var snackBar = SnackBar(content: Text('Password Does\'t match'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        return;
                      }
                      else{

                        String response = await ServerHandler().changePassword(int.parse(widget.receivedMap['id']), widget.receivedMap['name'], newController.text, oldController.text);
                        print("response = $response");
                        if( response == "Success")
                        {
                          var snackBar = SnackBar(content: Text('Password Updated Successful'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }else{
                          var snackBar = SnackBar(content: Text("Old Password Doesn't Match"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }

                      }
                    }

                  //Navigator.of(context).pop();

                }, color: Color(0xff4A777A),),
              )
            ],),

        ),
      ),
    );
  }
}
