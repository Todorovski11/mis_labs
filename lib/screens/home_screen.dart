import 'package:flutter/material.dart';
import 'product_details.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'T-shirt',
      image: 'lib/assets/photo1.jpg', // Updated to use local image
      description: 'Comfortable cotton T-shirt.',
      price: '\$10',
    ),
    Product(
      name: 'Jeans',
      image: 'lib/assets/photo2.jpg', // Updated to use local image
      description: 'Classic blue denim jeans.',
      price: '\$40',
    ),
    Product(
      name: 'Jacket',
      image: 'lib/assets/photo3.jpg', // Updated to use local image
      description: 'Stylish leather jacket.',
      price: '\$100',
    ),
    Product(
      name: 'Sneakers',
      image: 'lib/assets/photo4.jpg', // Updated to use local image
      description: 'Comfortable running sneakers.',
      price: '\$60',
    ),
    Product(
      name: 'Hat',
      image: 'lib/assets/photo5.jpg', // Updated to use local image
      description: 'Stylish summer hat.',
      price: '\$25',
    ),
    Product(
      name: 'Scarf',
      image: 'lib/assets/photo6.jpg', // Updated to use local image
      description: 'Warm and cozy scarf.',
      price: '\$15',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Индекс: 211239'), // Replace with your index
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(product.image, height: 80, fit: BoxFit.cover), // Updated to Image.asset
                  SizedBox(height: 8.0),
                  Text(product.name, style: TextStyle(fontSize: 16.0)),
                  Text(product.price, style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
