import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:elisam_store_management/widgets/add_product_button.dart';
import 'package:elisam_store_management/widgets/product_details_sheet.dart';
import 'package:elisam_store_management/models/productdata.dart';
import 'package:elisam_store_management/models/category.dart';
import 'package:elisam_store_management/models/categories.dart'; // Your categories import
import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
    // Using your existing categories list
    List<Category> availableCategories = Categories.list;

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
                        _navigateToAddProduct(context, availableCategories);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        _buildProductGrid(categoryProducts),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(context, products[index]);
      },
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Price: ${product.price}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      'Qty: ${product.quantityLeft}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: product.quantityLeft > 0
                            ? Colors.green
                            : Colors.red,
                      ),
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
