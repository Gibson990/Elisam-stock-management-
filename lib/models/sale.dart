import 'package:elisam_store_management/models/product.dart';

class Sale {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double totalAmount;

  Sale({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
  });
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}
