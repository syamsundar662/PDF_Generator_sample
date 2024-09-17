import 'package:firebase_realtime/model/product_model.dart';
import 'package:firebase_realtime/services/pdf_api.dart';
import 'package:firebase_realtime/ui/user_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_realtime/services/firebase.dart';
import 'package:firebase_realtime/model/model.dart'; // Import the Product model

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // List of available products
  final List<Product> products = [
    Product(id: '001', name: 'Smartphone', price: 699.99),
    Product(id: '002', name: 'Laptop', price: 999.99),
    Product(id: '003', name: 'Headphones', price: 199.99),
    Product(id: '004', name: 'Smartwatch', price: 249.99),
    Product(id: '005', name: 'Tablet', price: 499.99),
  ];

  Product? selectedProduct;
  int quantity = 1; // Start with 1 product
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    selectedProduct = products[0];
    totalPrice = selectedProduct!.price;
  }

  void calculateTotalPrice() {
    setState(() {
      totalPrice = selectedProduct!.price * quantity;
    });
  }

  void writeData() {
    if (selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a product')),
      );
      return;
    }

    UserModel newUser = UserModel(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      product: selectedProduct!,
      quantity: quantity,
      totalPrice: totalPrice,
    );

    _firebaseService.addUser(newUser).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      setState(() {
        selectedProduct = products[0];
        quantity = 1;
        totalPrice = selectedProduct!.price;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserScreen()));
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            DropdownButton<Product>(
              value: selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  selectedProduct = newValue;
                });
              },
              items: products.map<DropdownMenuItem<Product>>((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text('${product.name} (\$${product.price})'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Add product count control
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (productCount > 1) {
                      setState(() {
                        productCount--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('Quantity: $productCount'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      productCount++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Display original price, GST, and total price with GST based on count
            if (selectedProduct != null) ...[
              Text(
                  'Original Price: \$${(selectedProduct!.price * productCount).toStringAsFixed(2)}'),
              Text(
                  'GST (18%): \$${(selectedProduct!.price * selectedProduct!.gst * productCount).toStringAsFixed(2)}'),
              Text(
                  'Total Price with GST: \$${(selectedProduct!.getPriceWithGst() * productCount).toStringAsFixed(2)}'),
            ],

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: writeData,
              child: const Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_realtime/ui/user_list.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_realtime/services/firebase.dart';
// import 'package:firebase_realtime/model/model.dart'; // Import the Product model

// final Map<Product, int> selectedProduct = {}; // Track selected product IDs and their quantities
// int quantity = 1; // Default quantity for individual product
// double totalPrice = 0.0;

// class AddScreen extends StatefulWidget {
//   const AddScreen({super.key});

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> {
//   final FirebaseService _firebaseService = FirebaseService();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();

//   // List of available products
//   final List<Product> products = [
//     Product(id: '001', name: 'Smartphone', price: 699.99),
//     Product(id: '002', name: 'Laptop', price: 999.99),
//     Product(id: '003', name: 'Headphones', price: 199.99),
//     Product(id: '004', name: 'Smartwatch', price: 249.99),
//     Product(id: '005', name: 'Tablet', price: 499.99),
//   ];

//   final Map<String, int> selectedProducts = {}; // Track selected product IDs and their quantities
//   double totalPrice = 0.0;

//   void addProduct(Product product) {
//     setState(() {
//       if (selectedProducts.containsKey(product.id)) {
//         selectedProducts[product.id] = selectedProducts[product.id]! + 1;
//       } else {
//         selectedProducts[product.id] = 1;
//       }
//       calculateTotalPrice();
//     });
//   }

//   void removeProduct(Product product) {
//     setState(() {
//       if (selectedProducts.containsKey(product.id) && selectedProducts[product.id]! > 1) {
//         selectedProducts[product.id] = selectedProducts[product.id]! - 1;
//       } else {
//         selectedProducts.remove(product.id);
//       }
//       calculateTotalPrice();
//     });
//   }

//   void calculateTotalPrice() {
//     totalPrice = 0.0;
//     selectedProducts.forEach((productId, qty) {
//       final product = products.firstWhere((prod) => prod.id == productId);
//       totalPrice += product.getPriceWithGst() * qty;
//     });
//   }

//   void writeData() {
//     UserModel newUser = UserModel(
//       name: _nameController.text,
//       email: _emailController.text,
//       phone: _phoneController.text,
//       products: selectedProduct, // Pass the selected product IDs and quantities
//       totalPrice: totalPrice, // Pass the total calculated price
//     );

//     _firebaseService.addUser(newUser).then((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User added successfully')),
//       );
//       _nameController.clear();
//       _emailController.clear();
//       _phoneController.clear();
//       setState(() {
//         selectedProducts.clear();
//         totalPrice = 0.0; // Reset total price after adding the user
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add User'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserScreen()));
//             },
//             icon: const Icon(Icons.list),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: const InputDecoration(labelText: 'Phone'),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     title: Text('${product.name} (\$${product.price})'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove),
//                           onPressed: () => removeProduct(product),
//                         ),
//                         Text('${selectedProducts[product.id] ?? 0}'),
//                         IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: () => addProduct(product),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 writeData(); // Correctly calling the method
//               },
//               child: const Text('Save Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
