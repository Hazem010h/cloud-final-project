class ProductModel {
  String? sId;
  String? name;
  String? image;
  String? description;
  int? quantity;
  int? price;

  ProductModel({this.sId, this.name,this.description ,this.image,this.quantity, this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image=json['image'];
    description=json['description'];
    quantity = json['quantity'];
    price = json['price'];
  }

}
