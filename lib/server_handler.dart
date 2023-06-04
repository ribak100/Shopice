import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopice/models/buyer.dart';


import './models/seller.dart';
import './models/product.dart';
import './models/cartModel.dart';
import './models/buying.dart';
import './models/priceAndCount.dart';

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


  // method to delete data from the buy table
  Future<String> deleteFromBuy(int buyer_id, String image) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/delete?buyer_id=$buyer_id&image=$image'));
   return "success";
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
  // method to delete data from the buy table instant
  Future<String> deleteInstantFromBuy(int buyer_id, String buyer_name) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/deleteFresh?buyer_id=$buyer_id&buyer_name=$buyer_name'));
   return "success";
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


//function to get image from buy table
  Future<String> getImage(int sellerId, int buyerId,String price, String name) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/get_image?seller_id=$sellerId&buyer_id=$buyerId&price=$price&product_name=$name'));

      String image = response.body;
      return image;

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

//function to set quantity
  Future<String> quantity(int sellerId,String image,int buyerID, int quantity) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/quantity?seller_id=$sellerId&image=$image&buyer_id=$buyerID&quantity=$quantity'));

      String setQuantity = response.body;
      return setQuantity;

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


//function to set total_price
  void total_price(int sellerId,String image,int buyerID, int total_price) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/total_price?seller_id=$sellerId&image=$image&buyer_id=$buyerID&total_price=$total_price'));


    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

//function to set payment
  Future<String> payment(int sellerId,int buyerID, String payment) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/payment?seller_id=$sellerId&buyer_id=$buyerID&payment=$payment'));

      return "success";

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
//function to set shipping
  Future<String> shipping(int sellerId,String image,int buyerID, String shipping) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/shipping?seller_id=$sellerId&image=$image&buyer_id=$buyerID&shipping=$shipping'));

      return "success";

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
//function to set delivery
  Future<String> delivery(int sellerId,String image,int buyerID, String delivery) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/delivery?seller_id=$sellerId&image=$image&buyer_id=$buyerID&delivery=$delivery'));

      return "success";

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //function to get data in cart
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

  //get price from buy
  Future<List<Price>> getPrice(String buyer_name, int buyerId) async {
    try {
      List<Price> price = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/price?buyer_id=$buyerId&buyer_name=$buyer_name'));

      List priceList = json.decode(response.body)['price'];

      for (Map m in priceList) {
        price.add(Price.fromMap(m));
      }

      return price;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //get count from buy
  Future<List<Count>> getCount(String buyer_name, int buyerId) async {
    try {
      List<Count> count = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/count?buyer_id=$buyerId&buyer_name=$buyer_name'));

      List countList = json.decode(response.body)['count'];

      for (Map m in countList) {
        count.add(Count.fromMap(m));
      }

      return count;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }
  //get total from buy
  Future<List<Total>> getTotalPrice(String buyer_name, int buyerId) async {
    try {
      List<Total> total = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/get_total_price?buyer_id=$buyerId&buyer_name=$buyer_name'));

      print(json.decode(response.body)['price']);
      List totalList = json.decode(response.body)['price'];
      for (Map m in totalList) {
        if(totalList.isEmpty){
          print("total is empty");
        }else
          {
            total.add(Total.fromMap(m));
          }
      }

      return total;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get available product list
  Future<List<BuyModel>> getAvailableProducts(int sellerId, String sellerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/seller/getPaidOrders?seller_id=$sellerId&seller_name=$sellerName'));

      List productList = json.decode(response.body)['paid'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //get Shipped product list
  Future<List<BuyModel>> getShippedProducts(int sellerId, String sellerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/seller/getShipped?seller_id=$sellerId&seller_name=$sellerName'));

      List productList = json.decode(response.body)['shipped'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //get Delivered product list
  Future<List<BuyModel>> getDeliveredProducts(int sellerId, String sellerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/seller/getDelivered?seller_id=$sellerId&seller_name=$sellerName'));

      List productList = json.decode(response.body)['delivered'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  Future<List<Buyer>> eachBuyer(int buyerId, String buyerName) async {
    try {
      List<Buyer> buyer = [];

      http.Response response =
      await http.get(Uri.parse('$_baseUrl/buyer/eachBuyer?id=$buyerId&name=$buyerName'));

      List buyerList = (json.decode(response.body))['buyers'];

      for (Map m in buyerList) {
        buyer.add(Buyer.fromMap(m));
      }

      return buyer;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //get pending product list
  Future<List<BuyModel>> getPendingOrders(int buyerID, String buyerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/pending?buyer_id=$buyerID&buyer_name=$buyerName'));

      List pendingList = json.decode(response.body)['pend'];

      for (Map m in pendingList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print("Buy Model = $buyModel");

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //get paid product list
  Future<List<BuyModel>> getPaidOrderBuyer(int buyerID, String buyerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/pendingShipment?buyer_id=$buyerID&buyer_name=$buyerName'));

      List productList = json.decode(response.body)['paid'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get paid product list
  Future<List<BuyModel>> getShippedOrderBuyer(int buyerID, String buyerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/shippedBuyer?buyer_id=$buyerID&buyer_name=$buyerName'));

      List productList = json.decode(response.body)['paid'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get paid product list
  Future<List<BuyModel>> getCompletedOrderBuyer(int buyerID, String buyerName) async {
    try {
      List<BuyModel> buyModel = [];

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/completedOrder?buyer_id=$buyerID&buyer_name=$buyerName'));

      List productList = json.decode(response.body)['paid'];

      for (Map m in productList) {
        buyModel.add(BuyModel.fromMap(m));
      }

      print(buyModel);

      return buyModel;
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get paid product list
  Future<bool> updateBuyerDetails(int buyerID, String email,String name, String address, String phone_number, String country, String nationality, String postal_code, String shipping_address ) async {
    try {

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/complete_registration?name=$name&phone_number=$phone_number&country=$country&address=$address&shipping_address=$shipping_address&id=$buyerID&nationality=$nationality&postal_code=$postal_code&email=$email'));


      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }


    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }

  //get paid product list
  Future<String> changePassword(int buyerId, String buyerName, String newPassword, String oldPassword) async {
    try {

      http.Response response = await http
          .get(Uri.parse('$_baseUrl/buyer/new_password?id=$buyerId&name=$buyerName&newPassword=$newPassword&oldPassword=$oldPassword'));

      if(response.statusCode == 200){
        return response.body;
      }
      else{
        return response.body;
      }


    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


//function to set cart order to buy, ready to be removed
  Future<String> buy(int sellerId,String image,int buyerID) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/removeFromCart?seller_id=$sellerId&image=$image&buyer_id=$buyerID'));



      return "success";

    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }


  //delete from cart
  Future<String> deleteCartProduct(int buyerId, String buyerName) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$_baseUrl/buyer/deleteFromCart?buyer_id=$buyerId&buyer_name=$buyerName'));

      return "success";
    } catch (e) {
      print("Server Handler : error : $e");
      rethrow;
    }
  }



}





