import 'package:elisam_store_management/models/category.dart';

class Product {
  final String id;
  final String name;
  final String price;
  int quantityLeft;
  final String description;
  final String categoryId; // Add this line
  final Category category;
  final String imageUrl;
  List<String> barcodes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantityLeft,
    required this.description,
    required this.categoryId, // Add this line
    required this.category,
    required this.imageUrl,
    required List<String>? barcodes,
  }) : barcodes = barcodes ?? [];
}
