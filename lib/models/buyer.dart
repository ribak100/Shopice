class Buyer{
  int? id;
  String? name;
  String? email;
  String? image;
  String? address;
  String? phone_number;
  String? country;
  String? nationality;
  String? postal_code;
  String? shipping_address;

  Buyer.fromMap(Map<dynamic, dynamic> map){
    id = int.parse(map['id']);
    name = map['name'];
    email = map['email'];
    image = map['image'];
    address = map['address'];
    phone_number = map['phone_number'];
    country = map['country'];
    nationality = map['nationality'];
    postal_code = map['postal_code'];
    shipping_address = map['shipping_address'];


  }
}

