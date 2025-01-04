import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/product.dart';
// import 'package:elisam_store_management/widgets/add_product_button.dart';
import 'package:elisam_store_management/widgets/product_details_sheet.dart';
import 'package:elisam_store_management/models/productdata.dart';
import 'package:elisam_store_management/models/category.dart';
import 'package:elisam_store_management/models/categories.dart'; // Your categories import
import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

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
    List<Category> availableCategories = Categories.list;
    final isSmallScreen = MediaQuery.of(context).size.width <= 600;

    List<Product> filteredProducts = products.where((product) {
      final nameLower = product.name.toLowerCase();
      final searchLower = searchText.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    Widget addProductButton = Container(
      height: 48, // Reduced height from 56 to 48
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade500,
            Colors.blue.shade600,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          _navigateToAddProduct(context, availableCategories);
        },
        icon:
            const Icon(Icons.add, color: Colors.white, size: 20), // Reduced icon size
        label: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14, // Reduced font size
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isSmallScreen) ...[
                _buildSearchBar(),
                const SizedBox(height: 12),
                addProductButton,
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _buildSearchBar(),
                    ),
                    const SizedBox(width: 16.0),
                    addProductButton,
                  ],
                ),
              ],
              const SizedBox(height: 20),
              _buildCategorySection('Most Sold',
                  _filterProductsByCategory(filteredProducts, 'Most Sold')),
              _buildCategorySection(
                  'Recently Added',
                  _filterProductsByCategory(
                      filteredProducts, 'Recently Added')),
              _buildCategorySection('Out of Stock',
                  _filterProductsByCategory(filteredProducts, 'Out of Stock')),
              _buildCategorySection('All Categories', filteredProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.indigo.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
        decoration: InputDecoration(
          labelText: 'Search Products',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Search by name, category...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.indigo[400],
            size: 22,
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400]),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchText = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo[300]!, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  List<Product> _filterProductsByCategory(
      List<Product> products, String category) {
    if (category == 'Out of Stock') {
      return products.where((product) => product.quantityLeft == 0).toList();
    } else if (category == 'Most Sold') {
      return products.take(5).toList(); // Adjust logic for most sold
    } else if (category == 'Recently Added') {
      return products.reversed
          .take(5)
          .toList(); // Assuming most recent are last
    }
    return [];
  }

  Widget _buildCategorySection(String title, List<Product> categoryProducts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        _buildProductGrid(categoryProducts),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 600;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallScreen ? 2 : 4,
        childAspectRatio:
            isSmallScreen ? 0.6 : 0.7, // Adjusted for small screens
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(context, products[index]);
      },
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 600;

    return GestureDetector(
      onTap: () {
        _showProductDetailsSheet(context, product);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: isSmallScreen
                  ? 3
                  : 2, // More space for content on small screens
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14.0 : 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        product.description,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12.0 : 14.0,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.price,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13.0 : 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo[700],
                          ),
                        ),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: product.quantityLeft > 0
                                ? Colors.green[50]
                                : Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Qty: ${product.quantityLeft}',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12.0 : 13.0,
                              fontWeight: FontWeight.w500,
                              color: product.quantityLeft > 0
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetailsSheet(BuildContext context, Product product) {
    showProductDetailsSheet(
      context,
      product,
      onDelete: () {
        _deleteProduct(product);
        Navigator.pop(context);
      },
      onEdit: (editedProduct) {
        _editProduct(editedProduct);
        Navigator.pop(context);
      },
      onUpdateProduct: (updatedProduct) {
        _updateProduct(updatedProduct);
      },
      categoryId: product.categoryId,
    );
  }

  void _deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  void _editProduct(Product editedProduct) {
    setState(() {
      int index =
          products.indexWhere((product) => product.id == editedProduct.id);
      if (index != -1) {
        products[index] = editedProduct;
      }
    });
  }

  void _updateProduct(Product updatedProduct) {
    setState(() {
      int index =
          products.indexWhere((product) => product.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
      }
    });
  }

  void _navigateToAddProduct(
      BuildContext context, List<Category> availableCategories) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddProductScreen(
                categories: availableCategories,
              )),
    ).then((newProduct) {
      if (newProduct != null) {
        setState(() {
          products.add(newProduct);
        });
      }
    });
  }
}
