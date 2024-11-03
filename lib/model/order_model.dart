class OrderModel {
  final int? id;
  final DateTime? createdAt;
  final String uid;
  final int productId;
  final bool isInTransit;
  final bool isDelivered;
  final int quantity;

  OrderModel({
    required this.uid,
    required this.productId,
    required this.isInTransit,
    required this.isDelivered,
    required this.quantity,
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
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      uid: map['uid'],
      productId: map['productId'],
      isInTransit: map['isInTransit'],
      isDelivered: map['isDelivered'],
      quantity: map['quantity'],
    );
  }
}
