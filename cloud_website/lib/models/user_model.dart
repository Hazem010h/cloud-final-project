class UserModel {
  String? message;
  User? user;

  UserModel({this.message, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

}

class User {
  String? sId;
  String? name;
  String? email;
  String? password;

  User({this.sId, this.name, this.email, this.password,});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

}
