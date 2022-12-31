class BuyModel {
  String? buyerId;
  String? sellerId;
  String? sellerName;
  String? buyerName;
  String? price;
  String? productName;
  String? image;
  String? quantity;
  String? total_price;
  String? payment;
  String? shipping;
  String? delivery;

  BuyModel(
      {this.buyerId,
        this.sellerId,
        this.sellerName,
        this.buyerName,
        this.price,
        this.productName,
        this.image,
        this.quantity,
        this.total_price,
        this.payment,
        this.shipping,
        this.delivery});

  BuyModel.fromMap(Map<dynamic, dynamic> map) {
    buyerId = map['buyer_id'];
    sellerId = map['seller_id'];
    sellerName = map['seller_name'];
    buyerName = map['buyer_name'];
    price = map['price'];
    productName = map['product_name'];
    image = map['image'];
    quantity = map['quantity'];
    total_price = map['total_price'];
    payment = map['payment'];
    shipping = map['shipping'];
    delivery = map['delivery'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['buyer_name'] = this.buyerName;
    data['price'] = this.price;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['payment'] = this.payment;
    data['shipping'] = this.shipping;
    data['delivery'] = this.delivery;
    return data;
  }
}