import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';



class ViewProfile extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  const ViewProfile({Key? key, required this.receivedMap}) : super(key: key);


  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, right: 200.0, left: 20.0, bottom: 50.0),
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

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(children: [
              Row(children: [
                Text("Name: ",
                  style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                  color: Colors.black54,
                  ),),

                Text(widget.receivedMap['name'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Phone Number: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text("*****number",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),
              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Email: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text(widget.receivedMap['email'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Country: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text("****country",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Nationality: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text("***nationality",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("postal Code: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text("***postal code",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Address: ",overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text(widget.receivedMap['address'],overflow: TextOverflow.ellipsis, softWrap: true, maxLines: 1,
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
                color: Colors.black54,
                ),),

              ],),
              Divider(thickness: 2.0,),
              SizedBox(height: 10.0,),

              Row(children: [
                Text("Shipping Address: ",overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black54,
                  ),),

                Text("****shipping",overflow: TextOverflow.ellipsis, softWrap: true, maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                    color: Colors.black54,
                  ),),
              ],),
              Divider(thickness: 2.0,),



            ],),
          ),





        ],),
    );
  }
}
