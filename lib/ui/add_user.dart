import 'package:firebase_realtime/model/product_model.dart';
import 'package:firebase_realtime/ui/user_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_realtime/services/firebase.dart';
import 'package:firebase_realtime/model/model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

//latest
class _AddScreenState extends State<AddScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Product> products = [
    Product(id: '001', name: 'Smartphone', price: 699.99),
    Product(id: '002', name: 'Laptop', price: 999.99),
    Product(id: '003', name: 'Headphones', price: 199.99),
    Product(id: '004', name: 'Smartwatch', price: 249.99),
    Product(id: '005', name: 'Tablet', price: 499.99),
  ];

  List<Product> selectedProducts = [];
  List<int> quantities = [];
  double totalPrice = 0.0;

  void addProduct(int index) {
    setState(() {
      selectedProducts.add(products[index]); // Add default selected product
      quantities.add(1); // Default quantity
      calculateTotalPrice();
    });
  }

  void removeProduct(int index) {
    setState(() {
      selectedProducts.removeAt(index);
      quantities.removeAt(index);
      calculateTotalPrice();
    });
  }

  void writeData() {
    if (selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one product')),
      );
      return;
    }

    UserModel newUser = UserModel(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      products: selectedProducts,
      quantities: quantities,
      totalPrice: totalPrice,
    );

    _firebaseService.addUser(newUser).then((_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      setState(() {
        selectedProducts.clear();
        quantities.clear();
        totalPrice = 0.0;
      });
    });
  }

  void calculateTotalPrice() {
    totalPrice = 0.0;
    for (int i = 0; i < selectedProducts.length; i++) {
      totalPrice += selectedProducts[i].getPriceWithGst() * quantities[i];
    }
    setState(() {});
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
        padding: const EdgeInsets.all(10.0),
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
            const SizedBox(
              height: 20,
            ),
            const Text('Products'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      addProduct(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.purple[100]),
                      height: 100,
                      child: Center(child: Text(products[index].name)),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedProducts[index].name),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (quantities[index] > 1) {
                                setState(() {
                                  quantities[index]--;
                                  calculateTotalPrice();
                                });
                              }
                            },
                          ),
                          Text(quantities[index].toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantities[index]++;
                                calculateTotalPrice();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => removeProduct(index),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Total Price with GST: \$${totalPrice.toStringAsFixed(2)}'),
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
