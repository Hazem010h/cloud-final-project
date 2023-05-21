class UserModel {
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? admin;
  List<Cart>? cart;
  int? iV;

  UserModel(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.admin,
        this.cart,
        this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    admin = json['admin'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    iV = json['__v'];
  }

}

class Cart {
  String? name;
  int? quantity;
  int? price;
  String? description;
  String? sId;

  Cart({this.name, this.quantity, this.price, this.description, this.sId});

  Cart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    sId = json['_id'];
  }

}
