import 'dart:convert';

import 'package:http/http.dart' as http;

import './models/seller.dart';

class ServerHandler{
  final String _baseUrl = "http://10.0.2.2:/shopice/api";

  //get list of sellers
  Future<List<Seller>> getSellers() async{
    try {
      List<Seller> sellers = [];

      http.Response response = await http.get(Uri.parse('$_baseUrl/gen/sellers'));

      List sellersList = (json.decode(response.body))['sellers'];

      for (Map m in sellersList){
        sellers.add(Seller.fromMap(m));
      }

      return sellers;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
}