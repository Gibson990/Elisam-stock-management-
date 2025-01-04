// import 'package:elisam_store_management/models/category.dart';
// import 'package:elisam_store_management/models/product.dart';
// import 'package:flutter/material.dart';

// class CategoryProductsScreen extends StatelessWidget {
//   final Category category;

//   const CategoryProductsScreen({Key? key, required this.category})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Filter products by category
//     List<Product> categoryProducts = productsByCategory[category.id] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${category.name} Products'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search products...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(16),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: categoryProducts.length,
//               itemBuilder: (context, index) {
//                 return _buildProductCard(context, categoryProducts[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductCard(BuildContext context, Product product) {
//     return GestureDetector(
//       onTap: () => _showProductDetailsScreen(context, product),
//       child: Card(
//         elevation: 4.0,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
//                 child: Image.network(product.imageUrl, fit: BoxFit.cover),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(product.name,
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis),
//                     Text(product.description,
//                         style:
//                             TextStyle(fontSize: 14.0, color: Colors.grey[700]),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis),
//                     Text('Price: ${product.price}',
//                         style: TextStyle(fontSize: 14.0)),
//                     Text('Qty: ${product.quantityLeft}',
//                         style: TextStyle(
//                             fontSize: 14.0,
//                             color: product.quantityLeft > 0
//                                 ? Colors.green
//                                 : Colors.red)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showProductDetailsScreen(BuildContext context, Product product) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => showModalBottomSheet(product: product),
//       ),
//     );
//   }
// }
