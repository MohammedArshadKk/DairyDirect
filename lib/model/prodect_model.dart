class ProductModel {
  final int? id;
  final String title;
  final String description;
  final String price;
  final String unit;
  final int quantity;
  final String imgUrl;

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.quantity,
    required this.imgUrl,
    this.id,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      unit: map['unit'],
      quantity: map['quantity'],
      imgUrl: map['imgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'unit': unit,
      'quantity': quantity,
      'imgUrl': imgUrl,
    };
  }
}
