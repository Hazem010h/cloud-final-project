class UserModel {
  List<Null>? cart;
  String? sId;
  String? name;
  String? email;
  String? password;

  UserModel(
      {this.cart, this.sId, this.name, this.email, this.password,});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Null>[];
    }
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

}
