class Product {
  final String id;
  final String name;
  final double price;
  final double gst;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      this.gst = 0.18}); 

  // Convert Product to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'gst': gst,
    };
  }

  // Factory constructor to create a Product from Firebase data
  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      gst: map['gst']?.toDouble() ?? 0.18, // Default GST is 18%
    );
  }

  // Method to calculate price with GST
  double getPriceWithGst() {
    return price + (price * gst);
  }
}
