import 'package:elisam_store_management/models/product.dart';
import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/productdata.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final _primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigo.shade500,
      Colors.blue.shade600,
    ],
  );

  final _secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.red.shade400,
      Colors.red.shade600,
    ],
  );

  final _disabledGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.grey.shade400, Colors.grey.shade600],
  );

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final List<CartItem> _cartItems = [];
  double _totalCost = 0.0;
  List<Product> _filteredProducts = products;
  final FocusNode _barcodeFocusNode = FocusNode();

  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

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
        const SnackBar(content: Text('Product not found')),
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
    setState(() {
      if (product.quantityLeft > 0) {
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

        // Show feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} added to cart'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'VIEW CART',
              onPressed: () {
                if (MediaQuery.of(context).size.width <= 600) {
                  _showCartModal(context);
                }
              },
            ),
          ),
        );
      }
    });
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
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    if (!isLargeScreen) {
      Navigator.pop(context); // Close the cart modal first
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Checkout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Items: ${_cartItems.length}'),
            const SizedBox(height: 8),
            Text('Total Amount: \$${_totalCost.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Proceed with original checkout logic
              for (var item in _cartItems) {
                // Update product quantities here if needed
              }
              _recordSale();
              _clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Transaction completed successfully!')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
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
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildInputFields(isLargeScreen),
              const SizedBox(height: 16),
              if (isLargeScreen)
                // Large Screen Layout
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, right: 24),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Available Products',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: _buildProductGrid(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: const EdgeInsets.only(top: 56),
                        child: _buildCart(isLargeScreen),
                      ),
                    ],
                  ),
                )
              else
                // Small Screen Layout
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Available Products',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildProductListView(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields(bool isLargeScreen) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: isLargeScreen
          ? Row(
              children: [
                Expanded(child: _buildBarcodeField()),
                const SizedBox(width: 24),
                Expanded(child: _buildSearchField()),
              ],
            )
          : Column(
              children: [
                _buildBarcodeField(),
                const SizedBox(height: 16),
                _buildSearchField(),
              ],
            ),
    );
  }

  Widget _buildBarcodeField() {
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
        controller: _barcodeController,
        focusNode: _barcodeFocusNode,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
        decoration: InputDecoration(
          labelText: 'Scan Barcode',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Scan or enter barcode',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.qr_code_scanner,
            color: Colors.indigo[400],
            size: 22,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: _primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 20),
              onPressed: _scanBarcode,
              color: Colors.white,
            ),
          ),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
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
        controller: _searchController,
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
          hintText: 'Enter product name',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.indigo[400],
            size: 22,
          ),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: _filterProducts,
      ),
    );
  }

  Widget _buildProductListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredProducts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey[100],
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[400],
                              ),
                            ),
                    ),
                    if (product.quantityLeft <= 5)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: product.quantityLeft == 0
                                ? Colors.red
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.quantityLeft == 0
                                ? 'Out of Stock'
                                : 'Low Stock',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Stock: ${product.quantityLeft}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.price,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAddToCartButton(product),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final crossAxisCount = isLargeScreen ? (screenWidth / 300).floor() : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) =>
          _buildProductCard(_filteredProducts[index]),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 140,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  product.imageUrl != null
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[100],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                          ),
                        ),
                  // Stock label
                  if (product.quantityLeft <= 5)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: product.quantityLeft == 0
                                ? [Colors.red.shade400, Colors.red.shade600]
                                : [
                                    Colors.orange.shade400,
                                    Colors.orange.shade600
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.quantityLeft == 0
                              ? 'Out of Stock'
                              : 'Low Stock',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.price,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  _buildAddToCartButton(product),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(Product product) {
    return Container(
      height: 26,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:
            product.quantityLeft > 0 ? _primaryGradient : _disabledGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ElevatedButton(
        onPressed:
            product.quantityLeft > 0 ? () => _addProductToCart(product) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_shopping_cart,
              size: 11,
              color: Colors.white,
            ),
            SizedBox(width: 3),
            Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCart(bool isLargeScreen,
      {bool showTitle = true, bool showTotal = true}) {
    return Column(
      children: [
        if (showTitle) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Text(
              'Shopping Cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
        ],
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: Text(
                    item.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.product.price),
                  trailing: _buildQuantityControls(item),
                ),
              );
            },
          ),
        ),
        // Only show total and action buttons if showTotal is true
        if (showTotal) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${_totalCost.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCartActionButtons(),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuantityControls(CartItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 24,
          ),
          color: Colors.red,
          onPressed: () => _removeProductFromCart(item),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${item.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
            size: 24,
          ),
          color: item.quantity < item.product.quantityLeft
              ? Theme.of(context).primaryColor
              : Colors.grey,
          onPressed: item.quantity < item.product.quantityLeft
              ? () => _addProductToCart(item.product)
              : null,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      ],
    );
  }

  void _showCartModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Cart items without total
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildCart(false, showTitle: false, showTotal: false),
              ),
            ),
            // Total section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${_totalCost.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCartActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: _secondaryGradient,
            ),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text(
                'Clear Cart',
                style: TextStyle(fontSize: 13),
              ),
              onPressed: _clearCart,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: _primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart_checkout, size: 18),
              label: const Text(
                'Checkout',
                style: TextStyle(fontSize: 13),
              ),
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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
