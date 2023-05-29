class SearchModel {
  String? message;
  List<Products>? products;

  SearchModel({this.message, this.products});

  SearchModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
  }

}

class Products {
  String? sId;
  String? name;
  String? image;
  int? quantity;
  int? price;
  String? description;
  int? iV;

  Products(
      {this.sId,
        this.name,
        this.quantity,
        this.image,
        this.price,
        this.description,
        this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image=json['image'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    iV = json['__v'];
  }

}
