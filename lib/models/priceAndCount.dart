class Price{

  String? price;

  Price.fromMap(Map<dynamic, dynamic> map){

    price = map['price'];


  }
}

class Count{

  String? quantity;

  Count.fromMap(Map<dynamic, dynamic> map){

    quantity = map['quantity'];


  }
}


class Total{

  int? totalPrice;

  Total.fromMap(Map<dynamic, dynamic> map){

    totalPrice = int.parse(map['total_price']);


  }
}

