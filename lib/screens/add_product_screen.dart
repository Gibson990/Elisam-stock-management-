import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Price'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Quantity Left'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle add product logic
              },
              child: const Text('Add Product'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
