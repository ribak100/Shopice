// class CartModel{
//   int? buyer_id;
//   int? seller_id;
//   String? seller_name;
//   String? buyer_name;
//   String? image;
//   String? price;
//   String? product_name;
//
//   CartModel.fromJson(Map<dynamic, dynamic> map){
//     buyer_id = int.parse(map['buyer_id']);
//     seller_id = int.parse(map['seller_id']);
//     seller_name = map['seller_name'];
//     buyer_name = map['buyer_name'];
//     image = map['image'];
//     price = map['price'];
//     product_name = map['product_name'];
//
//
//   }
// }
//


class CartModel {
  int? buyerId;
  int? sellerId;
  String? sellerName;
  String? buyerName;
  String? image;
  String? price;
  String? productName;

  CartModel(
      {this.buyerId,
        this.sellerId,
        this.sellerName,
        this.buyerName,
        this.image,
        this.price,
        this.productName});

  CartModel.fromJson(Map<String, dynamic> json) {
    buyerId = int.parse(json['buyer_id']);
    sellerId = int.parse(json['seller_id']);
    sellerName = json['seller_name'];
    buyerName = json['buyer_name'];
    image = json['image'];
    price = json['price'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['buyer_name'] = this.buyerName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['product_name'] = this.productName;
    return data;
  }
}
