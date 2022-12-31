import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopice/screens/splash_screen.dart';

import '../screens/sellers_screen.dart';

class ProfileScreenArguments{
  final Map<String, dynamic> receivedMap;


  ProfileScreenArguments(this.receivedMap
      );
}


class Profile extends StatefulWidget {
  static const routeName = '/profile-screen';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var mapResponseLogin = Map<String, dynamic>();


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ProfileScreenArguments;
    return Scaffold(backgroundColor: Color(0xffE6F3EC),

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 112.0,
                    width: 112.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://10.0.2.2:/shopice/assets/${args.receivedMap['image']}"),
                            fit: BoxFit.fitHeight),
                        shape: BoxShape.circle,
                        color: Colors.grey),
                  ),
                  Text(args.receivedMap['name'], style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: Container(width: MediaQuery.of(context).size.width, height: 160.0, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 250.0 ,top: 9.0),
                    child: Text(
                      "Orders",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.0,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Divider(thickness: 1.0,),

                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.wallet), color: Color(0xff4A777A),iconSize: 40.0),
                        Text("Pending", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Colors.black,)),
                      ],),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.pending), color: Color(0xff4A777A),iconSize: 40.0),
                        Text("To be shipped", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Colors.black,)),
                      ],),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.local_shipping), color: Color(0xff4A777A),iconSize: 40.0),
                        Text("Shipped", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Colors.black,)),
                      ],),
                    ),

                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.library_add_check), color: Color(0xff4A777A),iconSize: 40.0),
                        Text("To be reviewed", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Colors.black,)),
                      ],),
                    ),
                  ],

                  )



              ],),),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: Container(width: MediaQuery.of(context).size.width, height: 160.0, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 250.0 ,top: 9.0),
                    child: Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.0,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Divider(thickness: 1.0,),

                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 6.0, right: 10.0),
                      child: GestureDetector( onTap: () => print("View Profile"),
                        child: Container(height: 85.0, width: 100,decoration: BoxDecoration(color: Color(0xffD1DAE1), borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                            child: Column(children: [ Icon(Icons.person, size: 40.0,color: Color(0xff4A777A)),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text("View Profile", style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                  color: Colors.black,)),
                              ),
                            ],),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 6.0, right: 10.0),
                      child: GestureDetector(onTap: () => print("Edit Profile"),
                        child: Container(height: 85.0, width: 100,decoration: BoxDecoration(color: Color(0xffD1DAE1), borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                                child: Icon(Icons.edit_note, size: 40.0,color: Color(0xff4A777A)),
                              ),
                            Text("Edit Profile", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 6.0,),
                      child: GestureDetector( onTap: () {

                        var snackbar = SnackBar(
                          content: Text(
                              "Logout Succesfull",
                              style: TextStyle(fontSize: 20.0)),
                          backgroundColor:
                          const Color(0xff4A777A),
                          padding: EdgeInsets.only(left: 50.0),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackbar);

                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: RouteSettings(name: '/splash-screen'),
                            builder: (context) => SplashScreen(receivedMap: mapResponseLogin,)
                          ),
                        );



                      },
                        child: Container(height: 85.0, width: 100,decoration: BoxDecoration(color: Color(0xffD1DAE1), borderRadius: BorderRadius.circular(20.0)),
                          child:
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                              child: Icon(Icons.logout, size: 40.0,color: Color(0xff4A777A)),
                            ),
                            Text("Logout", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),
                      ),
                    ),
                  ],

                  )



                ],),),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: Container(width: MediaQuery.of(context).size.width, height: 160.0, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 250.0 ,top: 9.0),
                    child: Text(
                      "Share",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.0,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Divider(thickness: 1.0,),

                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 7.0, right: 15.0),
                      child: GestureDetector( onTap: () => print("Share"),
                        child: Container(height: 90.0, width: 150,decoration: BoxDecoration(color: Color(0xffD5DEDC), borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                  child: Icon(Icons.share, size: 50.0,color: Colors.grey),
                                ),
                              Text("Share", style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                                color: Colors.black,)),
                            ],),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 6.0, right: 10.0),
                      child: GestureDetector( onTap: () => print("Rate"),
                        child: Container(height: 90.0, width: 150,decoration: BoxDecoration(color: Color(0xffD4D3E0), borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0, bottom: 5.0),
                                child: Icon(Icons.star_border, size: 50.0,color: Colors.teal),
                              ),
                            Text("Rate", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),
                      ),
                    ),

                  ],

                  )



                ],),),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
              child: Container(width: MediaQuery.of(context).size.width, height: 260.0, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 240.0 ,top: 9.0),
                    child: Text(
                      "Services",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.0,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Divider(thickness: 1.0,),

                  Column(
                    children: [
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.account_balance_wallet), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Wallet\n", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 14),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.location_city), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Shipping\n Adress", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.insert_invitation), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Invite\n", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.support_agent), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Support\n", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),


                      ],

                      ),

                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.question_answer), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Questions &\n  Answers", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(children: [IconButton(onPressed: () => print('pressed'), icon: Icon(Icons.settings_suggest), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("       App\nsuggestions", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(children: [IconButton(onPressed: () {
                            var snackbar = SnackBar(
                              content: Text(
                                  "Logout Succesfull",
                                  style: TextStyle(fontSize: 20.0)),
                              backgroundColor:
                              const Color(0xff4A777A),
                              padding: EdgeInsets.only(left: 50.0),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);


                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  settings: RouteSettings(name: '/splash-screen'),
                                  builder: (context) => SplashScreen(receivedMap: mapResponseLogin,)
                              ),
                            );
                          }, icon: Icon(Icons.logout), color: Color(0xff4A777A),iconSize: 40.0),
                            Text("Logout\n", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              color: Colors.black,)),
                          ],),
                        ),
                      ],)
                    ],
                  )




                ],),),
            ),

          ],
        ),
      ),
    ),
    );
  }
}
