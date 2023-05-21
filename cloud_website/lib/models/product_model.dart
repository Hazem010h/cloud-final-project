class ProductModel {
  String? sId;
  String? name;
  String? description;
  int? quantity;
  int? price;

  ProductModel({this.sId, this.name,this.description ,this.quantity, this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description=json['description'];
    quantity = json['quantity'];
    price = json['price'];
  }

}
