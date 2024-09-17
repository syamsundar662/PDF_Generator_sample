import 'package:firebase_realtime/model/product_model.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String phone;
  List<Product> products;
  List<int> quantities;
  double totalPrice;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.products,
    required this.quantities,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'products': products.map((product) => product.toMap()).toList(),
      'quantities': quantities,
      'totalPrice': totalPrice,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      products: List<Product>.from(
          (map['products'] ?? []).map((item) => Product.fromMap(item))),
      quantities: List<int>.from(map['quantities'] ?? []),
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }
}
