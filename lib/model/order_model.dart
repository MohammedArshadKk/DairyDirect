class OrderModel {
  final int? id;
  final DateTime? createdAt;
  final String uid;
  final int productId;
  final bool isInTransit;
  final bool isDelivered;
  final int quantity;
  final String imageUrl;
  final String title;

  OrderModel({
    required this.uid,
    required this.productId,
    required this.isInTransit,
    required this.isDelivered,
    required this.quantity,
    required this.imageUrl,
    required this.title,
    this.id,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'productId': productId,
      'isInTransit': isInTransit,
      'isDelivered': isDelivered,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'title': title,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      uid: map['uid'],
      productId: map['productId'],
      isInTransit: map['isInTransit'],
      isDelivered: map['isDelivered'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
      title: map['title'],
    );
  }
// Future<>  getHistory() {

//   }
}
