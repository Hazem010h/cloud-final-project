class ProductModel {
  String? sId;
  String? name;
  int? quantity;
  int? price;

  ProductModel({this.sId, this.name, this.quantity, this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

}
