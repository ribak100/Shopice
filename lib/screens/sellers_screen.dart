import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopice/screens/sellers_screen.dart';

import '../models/seller.dart';
import '../widgets/seller_item.dart';
import './login.dart';
import './registration_seller.dart';
import './registration_buyer.dart';
import './loginBuyer.dart';

class ScreenArguments{
  List<Seller> seller;
  late final Map<String, dynamic> receivedMap;


  ScreenArguments(this.seller
  ,this.receivedMap
      );
}

class SellersScreen extends StatefulWidget {
  static const routeName = '/sellers_screen';


  const SellersScreen({Key? key}) : super(key: key);

  @override
  State<SellersScreen> createState() => _SellersScreenState();
}
//
// class RouteGenerator{
//   static Route<dynamic> generateRoute(RouteSettings settings){
//     final args = settings.arguments;
//     switch(settings.name){
//       case '/sellers_screen':
//         return CupertinoPageRoute(builder: (BuildContext context){
//           ScreenArguments arguments = args;
//         });
//     }
//   }
// }

class _SellersScreenState extends State<SellersScreen> {
  List<Color> sellerItemBackgroundColor = [];
  bool drawerVisible = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellerItemBackgroundColor.add(const Color(0xffE4EDF4));
    sellerItemBackgroundColor.add(const Color(0xffE6E6F2));
    sellerItemBackgroundColor.add(const Color(0xffE6F3EC));
    sellerItemBackgroundColor.add(const Color(0xffE4DAD9));
  }

  @override
  Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  var mapResponse = Map<String, dynamic>();
  mapResponse['id'] = args.receivedMap['id'];
  mapResponse['name'] = args.receivedMap['name'];
  mapResponse['email'] = args.receivedMap['email'];
  mapResponse['image'] = args.receivedMap['image'];
  mapResponse['address'] = args.receivedMap['address'];
  mapResponse['phone_number'] = args.receivedMap['phone_number'];
  mapResponse['postal_code'] = args.receivedMap['postal_code'];
  mapResponse['shipping_address'] = args.receivedMap['shipping_address'];
  mapResponse['country'] = args.receivedMap['country'];
  mapResponse['nationality'] = args.receivedMap['nationality'];

  if(args.receivedMap['id'] == null){
    drawerVisible = true;
  }
  else{
    drawerVisible = false;
  }

    List<Seller> sellers = args.seller;
    return Scaffold(
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

      drawer: Visibility(visible: drawerVisible,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(color: Color(0xffE6F3EC)),
                padding: EdgeInsets.only(top: 40.0, left: 15.0),
                child: Text(
                  "Shopice",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 23.0,
                    color: Color(0xff4E8489),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                onTap: ()=> Navigator.of(context).popAndPushNamed(LoginBuyer.routeName),
                minLeadingWidth: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: Text(
                  "Sign up",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () =>
                    Navigator.of(context).popAndPushNamed(
                        Registration_buyer.routeName),
                minLeadingWidth: 20.0,
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.question_mark),
                title: Text(
                  "About Us",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () => print('Login clicked'),
                minLeadingWidth: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(
                  "Contact US",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () => print('Login clicked'),
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
      ),
      body: Center(
        //alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Shopice",
                    //   style: GoogleFonts.poppins(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 23.0,
                    //     color: const Color(0xff4E8489),
                    //   ),
                    // ),
                  ],
                ),
              ),
              //list of sellers
              Column(
                children: sellers
                    .map((e) =>
                    SellerItem(
                      seller: e,
                      backgroundColor:
                      sellerItemBackgroundColor[sellers.indexOf(e) % 4], receivedMap: mapResponse,
                    )
                )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
