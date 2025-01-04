import 'package:uuid/uuid.dart';
import 'categories.dart';
import 'product.dart';

const uuid = Uuid();

List<Product> products = [
  Product(
    id: _generateRandomId(),
    name: 'Smartphone X',
    price: '\$999',
    quantityLeft: 15,
    description: 'Latest model with advanced camera and long-lasting battery.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Classic T-Shirt',
    price: '\$19.99',
    quantityLeft: 100,
    description: 'Comfortable cotton t-shirt available in various colors.',
    categoryId: '2',
    category: Categories.getById('2')!, // Clothing
    imageUrl:
        'https://images.unsplash.com/photo-1622470953794-aa9c70b0fb9d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Wireless Earbuds',
    price: '\$129',
    quantityLeft: 0,
    description:
        'High-quality sound with noise cancellation. Currently out of stock.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1590658006821-04f4008d5717?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Organic Coffee Beans',
    price: '\$14.50',
    quantityLeft: 50,
    description: 'Fair trade, medium roast coffee beans. 1 lb bag.',
    categoryId: '3',
    category: Categories.getById('3')!, // Groceries
    imageUrl:
        'https://images.unsplash.com/photo-1606486544554-164d98da4889?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Yoga Mat',
    price: '\$35',
    quantityLeft: 25,
    description: 'Non-slip, eco-friendly yoga mat. Perfect for home workouts.',
    categoryId: '4',
    category: Categories.getById('4')!, // Sports & Fitness
    imageUrl:
        'https://images.unsplash.com/photo-1621886178958-be42369fc9e7?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Bestselling Novel',
    price: '\$24.99',
    quantityLeft: 5,
    description: 'Award-winning fiction novel. Limited stock available.',
    categoryId: '5',
    category: Categories.getById('5')!, // Books
    imageUrl:
        'https://images.unsplash.com/photo-1614544048536-0d28caf77f41?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Smart Watch',
    price: '\$199',
    quantityLeft: 30,
    description: 'Fitness tracker with heart rate monitor and GPS.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1549482199-bc1ca6f58502?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Portable Charger',
    price: '\$49.99',
    quantityLeft: 0,
    description: '20000mAh power bank. Out of stock due to high demand.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1594549181132-9045fed330ce?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Espresso Machine',
    price: '\$249',
    quantityLeft: 10,
    description: 'Brews cafe-quality espresso at home. Includes milk frother.',
    categoryId: '6',
    category: Categories.getById('6')!, // Home & Kitchen
    imageUrl:
        'https://images.unsplash.com/photo-1585498121435-ef46fae0b307?q=80&w=1514&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Bluetooth Speaker',
    price: '\$89.99',
    quantityLeft: 40,
    description: 'Portable speaker with deep bass and 24-hour battery life.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1572919985781-3fdfb1c53c28?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Electric Kettle',
    price: '\$39.99',
    quantityLeft: 35,
    description: 'Quick-boil electric kettle with auto shut-off feature.',
    categoryId: '6',
    category: Categories.getById('6')!, // Home & Kitchen
    imageUrl:
        'https://images.unsplash.com/photo-1607082340394-8e6f03145f4e?q=80&w=1494&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
  Product(
    id: _generateRandomId(),
    name: 'Gaming Mouse',
    price: '\$59.99',
    quantityLeft: 20,
    description: 'Ergonomic gaming mouse with customizable RGB lighting.',
    categoryId: '1',
    category: Categories.getById('1')!, // Electronics
    imageUrl:
        'https://images.unsplash.com/photo-1587462601558-72e4ed4857f7?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    barcodes: [],
  ),
];

List<Product> getProductsByCategoryId(String categoryId) {
  return products.where((product) => product.categoryId == categoryId).toList();
}

Map<String, List<Product>> organizeProductsByCategory() {
  Map<String, List<Product>> productsByCategory = {};
  for (var product in products) {
    if (!productsByCategory.containsKey(product.categoryId)) {
      productsByCategory[product.categoryId] = [];
    }
    productsByCategory[product.categoryId]!.add(product);
  }
  return productsByCategory;
}

void updateProductBarcode(String productId, String newBarcode) {
  int index = products.indexWhere((product) => product.id == productId);
  if (index != -1) {
    products[index].barcodes.add(newBarcode);
  } else {
    print("Product with ID $productId not found.");
  }
}

String _generateRandomId() {
  return uuid.v4();
}
