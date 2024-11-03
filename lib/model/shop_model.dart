import 'dart:developer';

class ShopModel {
  final int? id;
  final String shopName;
  final String shopImg;
  final String phoneNo;
  final String shopLocation;
  final String uid;
  final String email;

  ShopModel({
    required this.shopName,
    required this.shopImg,
    required this.phoneNo,
    required this.shopLocation,
    required this.uid,
    required this.email,
    this.id,
  });

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'],
      shopName: map['shopName'],
      shopImg: map['shopImg'],
      phoneNo: map['phoneNo'],
      shopLocation: map['shopLocation'],
      uid: map['uid'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'shopImg': shopImg,
      'phoneNo': phoneNo,
      'shopLocation': shopLocation,
      'uid': uid,
      'email': email,
    };
  }

  
}
