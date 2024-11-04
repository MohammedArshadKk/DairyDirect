import 'dart:developer';

class ShopModel {
  final int? id;
  final String shopName;
  final String shopImg;
  final String phoneNo;
  final double latitude;
  final double longitude;
  final String uid;
  final String email;

  ShopModel({
    required this.shopName,
    required this.shopImg,
    required this.phoneNo,
    required this.latitude,
    required this.longitude,
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
      latitude: map['latitude'],
      longitude: map['longitude'],
      uid: map['uid'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'shopImg': shopImg,
      'phoneNo': phoneNo,
      'latitude': latitude,
      'longitude': longitude,
      'uid': uid,
      'email': email,
    };
  }
}
