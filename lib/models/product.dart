class Product{
  int? id;
  int? sellerId;
  String? name;
  String? image;
  String? pricePerKg;
  String? description;
  int? interactionCount;

  Product.fromMap(Map<dynamic, dynamic> map){
    id = int.parse(map['id']);
    sellerId = int.parse(map['seller_id']);
    name = map['name'];
    image = map['image'];
    pricePerKg = map['price_per_kg'];
    description = map['description'];
    interactionCount = int.parse(map['interaction_count']);

  }
}