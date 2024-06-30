import 'dart:math';
import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:elisam_store_management/screens/add_product_screen.dart';
import 'package:elisam_store_management/screens/edit_product_screen.dart';
import 'package:elisam_store_management/widgets/product_details_sheet.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [
    Product(
      id: _generateRandomId(),
      name: 'Product 1',
      price: '\$50',
      quantityLeft: 10,
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      category: 'Recently Added',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
    Product(
      id: _generateRandomId(),
      name: 'Product 2',
      price: '\$80',
      quantityLeft: 5,
      description: 'Nullam hendrerit ante non ipsum volutpat vestibulum.',
      category: 'Most Sold',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
    Product(
      id: _generateRandomId(),
      name: 'Product 3',
      price: '\$120',
      quantityLeft: 0,
      description: 'Pellentesque id turpis varius, fermentum velit sit amet.',
      category: 'Out of Stock',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
    Product(
      id: _generateRandomId(),
      name: 'Product 4',
      price: '\$90',
      quantityLeft: 8,
      description:
          'Vivamus rutrum ipsum non ex cursus, sit amet condimentum nunc luctus.',
      category: 'Recently Added',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
    Product(
      id: _generateRandomId(),
      name: 'Product 5',
      price: '\$60',
      quantityLeft: 3,
      description: 'Integer at augue quis nisi egestas fermentum in id ligula.',
      category: 'Most Sold',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
    Product(
      id: _generateRandomId(),
      name: 'Product 6',
      price: '\$100',
      quantityLeft: 12,
      description:
          'Fusce ultricies dolor sit amet ligula pretium, a tincidunt lacus commodo.',
      category: 'Recently Added',
      imageUrl:
          'https://images.unsplash.com/photo-1571335746824-742511d49bce?q=80&w=1374&auto=format&fit=crop',
    ),
  ];

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  Product? selectedProduct;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      searchText = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.where((product) {
      final nameLower = product.name.toLowerCase();
      final searchLower = searchText.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _buildSearchBar(),
                    ),
                    SizedBox(width: 16.0),
                    AddProductButton(
                      onPressed: () {
                        _navigateToAddProduct(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildCategorySections(filteredProducts),
              if (selectedProduct != null)
                ProductDetailsSheet(
                  product: selectedProduct!,
                  onDelete: _deleteProduct,
                  onEdit: _editProduct,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySections(List<Product> filteredProducts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCategorySection(
          'Recently Added',
          filteredProducts
              .where((p) => p.category == 'Recently Added')
              .toList(),
        ),
        _buildCategorySection(
          'Most Sold',
          filteredProducts.where((p) => p.category == 'Most Sold').toList(),
        ),
        _buildCategorySection(
          'Out of Stock',
          filteredProducts.where((p) => p.category == 'Out of Stock').toList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.0,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              setState(() {
                searchText = '';
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Product> categoryProducts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width > 600 ? 400.0 : 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(context, categoryProducts[index]);
            },
          ),
        ),
        if (categoryProducts.length > 4)
          TextButton(
            onPressed: () {
              // Navigate to view more products in this category
            },
            child: Text('View More'),
          ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        _showProductDetailsSheet(context, product);
      },
      child: Container(
        width: MediaQuery.of(context).size.width > 600
            ? 250.0
            : MediaQuery.of(context).size.width / 2,
        margin: EdgeInsets.only(right: 12.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height:
                      MediaQuery.of(context).size.width > 600 ? 200.0 : 120.0,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Price: ${product.price}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Qty Left: ${product.quantityLeft}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: product.quantityLeft > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    ).then((newProduct) {
      if (newProduct != null) {
        newProduct.id = _generateRandomId();
        setState(() {
          products.add(newProduct);
        });
      }
    });
  }

  void _deleteProduct() {
    if (selectedProduct != null) {
      setState(() {
        products.remove(selectedProduct);
        selectedProduct = null;
      });
      Navigator.pop(context); // Close the bottom sheet after deletion
    }
  }

  void _editProduct() {
    if (selectedProduct != null) {
      Navigator.pop(context); // Close the bottom sheet before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProductScreen(product: selectedProduct!),
        ),
      );
    }
  }

  void _showProductDetailsSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailsSheet(
          product: product,
          onDelete: _deleteProduct,
          onEdit: _editProduct,
        );
      },
    ).then((_) {
      setState(() {
        selectedProduct = null; // Clear selected product after closing sheet
      });
    });
  }

  static String _generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
          10, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.add),
        label: Text('Add Product'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
