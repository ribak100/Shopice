import 'dart:convert';

import 'package:http/http.dart' as http;

import './models/seller.dart';
import './models/product.dart';
import './models/cartModel.dart';

class ServerHandler {
  final String _baseUrl = "http://10.0.2.2:/shopice/api";

  //get list of sellers
  Future<List<Seller>> getSellers() async {
    try {
      List<Seller> sellers = [];

      http.Response response =
          await http.get(Uri.parse('$_baseUrl/gen/sellers'));

      List sellersList = (json.decode(response.body))['sellers'];

      for (Map m in sellersList) {
        sellers.add(Seller.fromMap(m));
      }

      return sellers;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get product list
  Future<List<Product>> getProductsPerSeller(int sellerId) async {
    try {
      List<Product> products = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/gen/products?seller_id=$sellerId'));

      List productList = json.decode(response.body)['products'];

      for (Map m in productList) {
        products.add(Product.fromMap(m));
      }

      return products;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  void getProductInteraction(int interaction, String name, int sellerId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/gen/interaction.php?interaction_count=$interaction&name=$name&seller_id=$sellerId'));
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  Future<String> editProduct(int sellerId, String image, String name, int price_per_kg, String description) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/seller/editProduct?seller_id=$sellerId&image=$image&name=$name&price_per_kg=price_per_kg&description=$description'));
   return "success";
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  Future<String> deleteProduct(int sellerId, String image) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/seller/deleteProduct?seller_id=$sellerId&image=$image'));
   return "success";
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }



  Future<List<CartModel>> getCart(int buyerId) async {
    try {


      final response = await http.get(Uri.parse(
          'http://10.0.2.2://shopice/api/buyer/getCart?buyer_id=$buyerId'));



      List<CartModel> cartModelList = (json.decode(response.body)['Cart Products'] as List)
              .map((data) => CartModel.fromJson(data))
              .toList();

      return cartModelList;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
}