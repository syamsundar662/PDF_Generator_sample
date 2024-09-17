import 'package:firebase_realtime/model/product_model.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String phone;
  Product product;
  int quantity;
  double totalPrice;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'product': product.toMap(),
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      product: Product.fromMap(map['product'] ?? {}),
      quantity: map['quantity'] ?? 1,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }
}
