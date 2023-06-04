import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';

import 'package:shopice/screens/QandA.dart';
import 'package:shopice/screens/about.dart';
import 'package:shopice/screens/deliveredOrder.dart';
import 'package:shopice/screens/pending.dart';
import 'package:shopice/screens/splash_screen.dart';
import '../screens/paidOrder.dart';
import '../screens/shipped.dart';
import '../screens/viewProfile.dart';
import '../screens/editProfile.dart';
import '../screens/changePassword.dart';
import '../utility/pageRoutes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/flatButton.dart';

// class ProfileScreenArguments {
//
//
//   ProfileScreenArguments(this.receivedMap);
// }

class Profile extends StatefulWidget {
  static const routeName = '/profile-screen';

  const Profile({Key? key, required this.receivedMap}) : super(key: key);
  final Map<String, dynamic> receivedMap;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  var mapResponseLogin = Map<String, dynamic>();
  TextEditingController appSuggesstionController = new TextEditingController();
  bool _validateAppSuggestion = false;

  TextEditingController subjectController = new TextEditingController();
  bool _validateSubject = false;

  AnimationController? _controller;
  Animation? _colorAnimation;
  late Animation<double> _sizeAnimation;
  Animation<double>? _curve;

  bool isRate = false;

  @override
  void initState() {
    super.initState();



    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _curve = CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);
    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Color(0xffECB40F))
            .animate(_controller!);



    //_controller!.addListener(() {});

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 55), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 55, end: 40), weight: 50)
    ]).animate(_curve!);

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isRate = true;
        });
      }

      if (status == AnimationStatus.dismissed) {
        setState(() {
          isRate = false;
        });
      }

      ;
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _launchWhatsapp(String name) async {
    var whatsapp = "+2348089222398";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=Hi i'm $name and i'm contacting you because i have an issues with the shopice app which is .....");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  void _launchMailClient() async {
    const mailUrl = 'mailto:adekanyekabir@gmail.com';
    try {
      await launch(mailUrl);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: 'adekanyekabir@gmail.com'));
    }
  }

  _launchMailto(String body, String name, String email, String subject) async {
    final mailtoLink = Mailto(
      to: ['adekanyekabir@gmail.com'],
      subject: "$subject  Sent from: $name",
      body: "$body",
    );
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    // final widget = ModalRoute.of(context)!.settings.arguments as ProfileScreenArguments;
    return Scaffold(
      backgroundColor: Color(0xffE6F3EC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: "profile_image.${widget.receivedMap['image']}",
                      child: Container(
                        height: 112.0,
                        width: 112.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://10.0.2.2:/shopice/assets/${widget.receivedMap['image']}"),
                                fit: BoxFit.fitHeight),
                            shape: BoxShape.circle,
                            color: Colors.grey),
                      ),
                    ),
                    Text(
                      widget.receivedMap['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 250.0, top: 9.0),
                        child: Text(
                          "Orders",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        CustomPageRouteLR(
                                            child: Pending(
                                                receivedMap: widget.receivedMap),
                                            direction: AxisDirection.right)),
                                    icon: Icon(Icons.wallet),
                                    color: Color(0xff4A777A),
                                    iconSize: 40.0),
                                Text("Pending",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        FadePageRouteLR(
                                            child: PaidOrder(
                                                receivedMap: widget.receivedMap),
                                            direction: AxisDirection.right)),
                                    icon: Icon(Icons.pending),
                                    color: Color(0xff4A777A),
                                    iconSize: 40.0),
                                Text("To be shipped",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        FadePageRouteLR(
                                            child: Shipped(
                                                receivedMap: widget.receivedMap),
                                            direction: AxisDirection.left)),
                                    icon: Icon(Icons.local_shipping),
                                    color: Color(0xff4A777A),
                                    iconSize: 40.0),
                                Text("Shipped",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                        CustomPageRouteLR(
                                            child: DeliveredOrder(
                                                receivedMap: widget.receivedMap),
                                            direction: AxisDirection.left)),
                                    icon: Icon(Icons.library_add_check),
                                    color: Color(0xff4A777A),
                                    iconSize: 40.0),
                                Text("To be reviewed",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 250.0, top: 9.0),
                        child: Text(
                          "Profile",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 6.0, right: 10.0),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  ScaleFadePageRouteLR(
                                      child: ViewProfile(
                                          receivedMap: widget.receivedMap),
                                      direction: AxisDirection.right)),
                              child: Container(
                                height: 85.0,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xffD1DAE1),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.person,
                                          size: 40.0, color: Color(0xff4A777A)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text("View Profile",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.0,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 6.0, right: 10.0),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  FadeScalePageRoute(
                                      child: EditProfile(
                                          receivedMap: widget.receivedMap))),
                              child: Container(
                                height: 85.0,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xffD1DAE1),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10.0,
                                          bottom: 5.0),
                                      child: Icon(Icons.edit_note,
                                          size: 40.0, color: Color(0xff4A777A)),
                                    ),
                                    Text("Edit Profile",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              top: 6.0,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  ScaleFadePageRouteLR(
                                      child: ChangePassword(
                                          receivedMap: widget.receivedMap),
                                      direction: AxisDirection.left)),
                              child: Container(
                                height: 85.0,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xffD1DAE1),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10.0,
                                          bottom: 5.0),
                                      child: Icon(Icons.password,
                                          size: 40.0, color: Color(0xff4A777A)),
                                    ),
                                    Text("Password",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 250.0, top: 9.0),
                        child: Text(
                          "Share",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 7.0, right: 15.0),
                            child: GestureDetector(
                              onTap: () => print("Share"),
                              child: Container(
                                height: 90.0,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color(0xffD5DEDC),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 2.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        child: Icon(Icons.share,
                                            size: 50.0, color: Colors.grey),
                                      ),
                                      Text("Share",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.0,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 6.0, right: 10.0),
                            child: GestureDetector(
                              onTap: () => {
                                isRate
                                    ? _controller!.reverse()
                                    : _controller!.forward()
                              },
                              child: Container(
                                height: 90.0,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color(0xffD4D3E0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0, //top: 7.0, bottom: 5.0
                                      ),
                                      child: AnimatedBuilder(
                                        animation: _controller!,
                                        builder: (BuildContext context, _) {
                                          return IconButton(
                                            iconSize: _sizeAnimation.value,
                                            icon: Icon(
                                              Icons.star,
                                              color: _colorAnimation!.value,
                                            ),
                                            onPressed: () {
                                              isRate
                                                  ? _controller!.reverse()
                                                  : _controller!.forward();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Text("Rate",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 240.0, top: 9.0),
                        child: Text(
                          "Services",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 20.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          var snackBar = SnackBar(
                                              content: Text(
                                                  "Wallet Would Be Available Soon"));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        icon:
                                            Icon(Icons.account_balance_wallet),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Wallet\n",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 14),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () => {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Wrap(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20.0),
                                                          child: ListTile(
                                                            leading: Icon(
                                                              Icons.house,
                                                              size: 40.0,
                                                            ),
                                                            title: Text(
                                                              'Shipping Address : ${widget.receivedMap['shipping_address']} Postal Code : ${widget.receivedMap['postal_code']}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0),
                                                            ),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: Icon(
                                                            Icons.edit,
                                                            color: Colors.grey,
                                                          ),
                                                          title: Text(
                                                            'You Can Change Shipping Address From Profile',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  })
                                            },
                                        icon: Icon(Icons.location_city),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Shipping\n Adress",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 15.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          var snackBar = SnackBar(
                                              content: Text(
                                                  "Invite Would Be Available Soon"));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        icon: Icon(Icons.insert_invitation),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Invite\n",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: LinearProgressIndicator(
                                              color: Color(0xff4A777A),
                                            ),
                                            backgroundColor: Colors.white,
                                          ));
                                          Future.delayed(Duration(seconds: 3),
                                              () {
                                            _launchWhatsapp(
                                                widget.receivedMap['name']);
                                          });
                                        },
                                        icon: Icon(Icons.support_agent),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Support\n",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () => Navigator.of(context)
                                            .push(ScaleFadePageRouteLR(
                                                child: QAndA(),
                                                direction: AxisDirection.up)),
                                        icon: Icon(Icons.question_answer),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Questions &\n  Answers",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 12.0, bottom: 0.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () => Navigator.of(context)
                                            .push(ScaleFadePageRouteLR(
                                                child: About(),
                                                direction: AxisDirection.up)),
                                        icon: Icon(Icons.question_mark),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("About\n   Us",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 8.0, bottom: 7.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: LinearProgressIndicator(color:Color(0xff4A777A) ,),backgroundColor: Colors.white,));
                                          // Future.delayed(Duration(seconds: 3), (){
                                          //   _launchMailClient();
                                          // });

                                          showModalBottomSheet<dynamic>(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Wrap(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        20.0),
                                                            child: TextField(
                                                              maxLines: 3,
                                                              minLines: 1,
                                                              decoration:
                                                                  InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xff4A777A)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                labelText:
                                                                    "Subject",
                                                                errorText:
                                                                    _validateSubject
                                                                        ? 'Please fill the Subject box'
                                                                        : null,
                                                              ),
                                                              controller:
                                                                  subjectController,
                                                            ),
                                                          ),
                                                          TextField(
                                                            maxLines: 15,
                                                            minLines: 10,
                                                            decoration:
                                                                InputDecoration(
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xff4A777A)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              labelText:
                                                                  "Suggestion",
                                                              errorText:
                                                                  _validateAppSuggestion
                                                                      ? 'Please fill the suggestion box'
                                                                      : null,
                                                            ),
                                                            controller:
                                                                appSuggesstionController,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 160.0,
                                                              top: 15.0),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            appSuggesstionController
                                                                    .text
                                                                    .isEmpty
                                                                ? _validateAppSuggestion =
                                                                    true
                                                                : _validateAppSuggestion =
                                                                    false;

                                                            subjectController
                                                                    .text
                                                                    .isEmpty
                                                                ? _validateSubject =
                                                                    true
                                                                : _validateSubject =
                                                                    false;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content:
                                                                LinearProgressIndicator(
                                                              color: Color(
                                                                  0xff4A777A),
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ));
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 3),
                                                              () {
                                                            _launchMailto(
                                                                appSuggesstionController
                                                                    .text,
                                                                widget.receivedMap[
                                                                    'name'],
                                                                widget.receivedMap[
                                                                    'email'],
                                                                subjectController
                                                                    .text);
                                                          });
                                                        },
                                                        color:
                                                            Color(0xff4A777A),
                                                        child: Text(
                                                          "Submit",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 280,
                                                    ),
                                                  ],
                                                );
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)));
                                        },
                                        icon: const Icon(Icons.settings_suggest),
                                        color: const Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("       App\nsuggestions",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          var snackbar = const SnackBar(
                                            content: Text("Logout Succesfull",
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                            backgroundColor:
                                                Color(0xff4A777A),
                                            padding:
                                                EdgeInsets.only(left: 50.0),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);

                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                settings: const RouteSettings(
                                                    name: '/splash-screen'),
                                                builder: (context) =>
                                                    SplashScreen(
                                                      receivedMap:
                                                          mapResponseLogin,
                                                    )),
                                          );
                                        },
                                        icon: Icon(Icons.logout),
                                        color: Color(0xff4A777A),
                                        iconSize: 40.0),
                                    Text("Logout\n",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
