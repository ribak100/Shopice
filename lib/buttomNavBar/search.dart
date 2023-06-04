import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopice/models/product.dart';
import 'package:shopice/screens/product_detail_screen.dart';

import '../models/seller.dart';

class Search extends StatefulWidget {
   Search(
      {Key? key,
      required this.data, required this.receivedMap, required this.seller})
      : super(key: key);

  final List<Product> data;
  final Map<String, dynamic> receivedMap;
  final Seller seller;


   @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin{
  late List<Product> displayList = List.from(widget.data);

  final TextEditingController _controller = new TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool searchClicked = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });


    _scaleAnimation = Tween<double>(begin: 1, end: 0.98).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));

    super.initState();
  }


  void updatedList(String value) {

    setState(() {
      displayList = widget.data.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TextField(
                        controller: _controller,
                      onChanged: (value){
                      updatedList(value);
                      displayList = widget.data.where((element) => element.name!.toLowerCase().contains(_controller.text.toLowerCase())).toList();

                      },
                      style: const TextStyle( color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon:  displayList.isEmpty? GestureDetector(onTap: (){
                          setState(() {
                            _controller.clear();
                          });
                        },
                            child: const Icon(Icons.close, color: Colors.black54,size: 29,)) :const Icon(
                          CupertinoIcons.mic,
                          color: Colors.black,
                        ),
                        hintText: 'Search for a Product',
                      ),
                    ),
                  ),
                  displayList.isEmpty? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children:const [
                        Text("Oh darn. We don't have that.", style: TextStyle(fontSize: 16, color: Colors.black),),
                        SizedBox(height: 5,),
                        Text("Try searching for another Product.", style: TextStyle(fontSize: 12, color: Colors.black),),
                      ],
                    ),
                  ) :const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10),
                    child: Text(
                      "Top Searches",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                  ...List.generate(
                      displayList.length,
                      (index) => Column(
                        children: [
                          SizedBox(height: 10,),
                          GestureDetector(
                              onTap: (){

                                Navigator.pushNamed(context, '/product-detaail-screen', arguments: DetailProduct(displayList[index], widget.seller, widget.receivedMap));


                              },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 100,
                                        child: Image(image: NetworkImage( "http://10.0.2.2:/shopice/assets/${displayList[index].image}"),)),
                                    SizedBox(width: 20,),
                                    Text(displayList[index].name!,style: TextStyle(color: Colors.black),),
                                    SizedBox(
                                      width: 100,
                                    ),
                                  ],),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: (){

                                      Navigator.pushNamed(context, '/product-detaail-screen', arguments: DetailProduct(displayList[index], widget.seller, widget.receivedMap));


                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 3.0,top: 2,right: 10),
                                      child: Icon(CupertinoIcons.arrow_right, color: Colors.black, size: 20,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}

