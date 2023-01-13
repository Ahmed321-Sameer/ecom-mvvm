class ProductModel {
  int? id;
  String? name;
  String? price;
  String? description;
  String? imagelink;

  ProductModel(
      {this.id, this.name, this.price, this.description, this.imagelink});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imagelink: json['imagelink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imagelink': imagelink,
    };
  }
}
