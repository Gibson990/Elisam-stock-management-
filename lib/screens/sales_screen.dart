import 'package:elisam_store_management/models/product.dart';
import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/productdata.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final List<CartItem> _cartItems = [];
  double _totalCost = 0.0;
  List<Product> _filteredProducts = products;
  final FocusNode _barcodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _barcodeController.addListener(_onBarcodeChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _barcodeFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _barcodeController.removeListener(_onBarcodeChanged);
    _barcodeController.dispose();
    _barcodeFocusNode.dispose();
    super.dispose();
  }

  void _onBarcodeChanged() {
    if (_barcodeController.text.isNotEmpty) {
      _processBarcode(_barcodeController.text);
      _barcodeController.clear();
    }
  }

  Future<void> _scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        _processBarcode(result.rawContent);
      }
    } catch (e) {
      print("Error scanning barcode: $e");
    }
  }

  void _processBarcode(String barcode) {
    Product? product = _findProductByBarcode(barcode);
    if (product != null) {
      _addProductToCart(product);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product not found')),
      );
    }
    _barcodeFocusNode.requestFocus();
  }

  Product? _findProductByBarcode(String barcode) {
    try {
      return products
          .firstWhere((product) => product.barcodes.contains(barcode));
    } catch (e) {
      return null;
    }
  }

  void _addProductToCart(Product product) {
    if (product.quantityLeft > 0) {
      setState(() {
        int index =
            _cartItems.indexWhere((item) => item.product.id == product.id);
        if (index != -1) {
          if (_cartItems[index].quantity < product.quantityLeft) {
            _cartItems[index].quantity++;
            product.quantityLeft--;
          }
        } else {
          _cartItems.add(CartItem(product: product));
          product.quantityLeft--;
        }
        _updateTotalCost();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} is out of stock')),
      );
    }
  }

  void _removeProductFromCart(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
        item.product.quantityLeft++;
      } else {
        _cartItems.remove(item);
        item.product.quantityLeft++;
      }
      _updateTotalCost();
    });
  }

  void _updateTotalCost() {
    _totalCost = _cartItems.fold(
        0,
        (sum, item) =>
            sum + (_parsePriceString(item.product.price) * item.quantity));
  }

  double _parsePriceString(String price) {
    return double.parse(price.replaceAll('\$', ''));
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
      _totalCost = 0.0;
    });
  }

  void _checkout() {
    // ignore: unused_local_variable
    for (var item in _cartItems) {
      // Update product quantities here if needed
      // item.product.quantityLeft -= item.quantity;
    }
    _recordSale();
    _clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction completed successfully!')),
    );
  }

  void _recordSale() {
    // Implement sale recording logic here
  }

  void _filterProducts(String query) {
    final filteredProducts = products.where((product) {
      final productName = product.name.toLowerCase();
      final input = query.toLowerCase();
      return productName.contains(input);
    }).toList();

    setState(() {
      _filteredProducts = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _scanBarcode,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBarcodeInput(),
            SizedBox(height: 10),
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildProductList(isLargeScreen)),
                  if (isLargeScreen) SizedBox(width: 20),
                  if (isLargeScreen) Expanded(child: _buildCart(isLargeScreen)),
                ],
              ),
            ),
            if (!isLargeScreen) SizedBox(height: 20),
            if (!isLargeScreen) _buildCart(isLargeScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeInput() {
    return TextField(
      controller: _barcodeController,
      focusNode: _barcodeFocusNode,
      decoration: InputDecoration(
        labelText: 'Scan Barcode',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(CommunityMaterialIcons.barcode_scan),
      ),
      onSubmitted: (value) {
        _processBarcode(value);
        _barcodeController.clear();
        _barcodeFocusNode.requestFocus();
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search Products',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _filterProducts(_searchController.text);
          },
        ),
      ),
      onChanged: _filterProducts,
    );
  }

  Widget _buildProductList(bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Products',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];

              return Card(
                elevation: 2,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: Container(
                    width: 80,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      // ignore: unnecessary_null_comparison
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                            )
                          : Center(child: Text('No Image')),
                    ),
                  ),
                  title: Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.price,
                          style: TextStyle(color: Colors.green)),
                      Text(
                        product.quantityLeft > 0
                            ? 'In stock: ${product.quantityLeft}'
                            : 'Out of Stock',
                        style: TextStyle(
                          color: product.quantityLeft > 0
                              ? Colors.black
                              : Colors.red,
                          fontWeight: product.quantityLeft > 0
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: product.quantityLeft > 0
                        ? () => _addProductToCart(product)
                        : null,
                    child: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: product.quantityLeft > 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCart(bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Cart',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _cartItems.isEmpty
            ? Center(child: Text('No items'))
            : Expanded(
                child: ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return ListTile(
                      title: Text(item.product.name),
                      subtitle:
                          Text('${item.quantity} x ${item.product.price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () => _removeProductFromCart(item),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: item.quantity < item.product.quantityLeft
                                ? () => _addProductToCart(item.product)
                                : null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        SizedBox(height: 10),
        Text(
          'Total: \$${_totalCost.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _checkout,
          child: Text('Checkout', style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        SizedBox(height: 10),
        if (!isLargeScreen)
          ElevatedButton(
            onPressed: _clearCart,
            child: Text('Clear Cart', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
      ],
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
