import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/categories.dart';
import 'package:elisam_store_management/models/category.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:elisam_store_management/models/productdata.dart';
import 'package:elisam_store_management/widgets/product_details_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Map<String, Map<String, dynamic>> categoryStyles = {
  'electronics': {
    'icon': Icons.devices,
    'colors': [Color(0xFF6C7FD8), Color(0xFF5163B3)],
  },
  'clothing': {
    'icon': Icons.checkroom,
    'colors': [Color(0xFFFF8C82), Color(0xFFE5484D)],
  },
  'groceries': {
    'icon': Icons.shopping_basket,
    'colors': [Color(0xFFAED581), Color(0xFF689F38)],
  },
  'sports & fitness': {
    'icon': Icons.fitness_center,
    'colors': [Color(0xFF4CC9F0), Color(0xFF4361EE)],
  },
  'books': {
    'icon': Icons.menu_book,
    'colors': [Color(0xFFF4A261), Color(0xFFE76F51)],
  },
  'home & kitchen': {
    'icon': Icons.kitchen,
    'colors': [Color(0xFF9B5DE5), Color(0xFF7209B7)],
  },
  'furniture': {
    'icon': Icons.chair,
    'colors': [Color(0xFFB39DDB), Color(0xFF673AB7)],
  },
  'automotive': {
    'icon': Icons.directions_car,
    'colors': [Color(0xFF64B5F6), Color(0xFF0D47A1)],
  },
  'car accessories': {
    'icon': Icons.car_repair,
    'colors': [Color(0xFF90CAF9), Color(0xFF1976D2)],
  },
  'toys': {
    'icon': Icons.toys,
    'colors': [Color(0xFFFED766), Color(0xFFFF9E00)],
  },
  'car electronics': {
    'icon': Icons.electrical_services,
    'colors': [Color(0xFFB39DDB), Color(0xFF673AB7)],
  },
  'car parts': {
    'icon': Icons.build,
    'colors': [Color(0xFF64B5F6), Color(0xFF0D47A1)],
  },
  'tires & wheels': {
    'icon': Icons.directions_car,
    'colors': [Color(0xFF90CAF9), Color(0xFF1976D2)],
  },
};

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  Map<String, List<Product>> productsByCategory = {};

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    productsByCategory = organizeProductsByCategory();
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

  List<Category> get filteredCategories {
    return Categories.list.where((category) {
      return category.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.indigo),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return _buildDesktopLayout();
                } else {
                  return _buildMobileLayout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        childAspectRatio: 1.2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          category: filteredCategories[index],
          onTap: () => _showCategoryProducts(filteredCategories[index]),
          showShadow: true,
          productCount:
              productsByCategory[filteredCategories[index].id]?.length ?? 0,
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        return CategoryTile(
          category: filteredCategories[index],
          onTap: () => _showCategoryProducts(filteredCategories[index]),
          productCount:
              productsByCategory[filteredCategories[index].id]?.length ?? 0,
        );
      },
    );
  }

  void _showCategoryProducts(Category category) {
    List<Product> categoryProducts = productsByCategory[category.id] ?? [];
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    Widget content = Stack(
      children: [
        ProductListView(
          category: category,
          products: categoryProducts,
          onProductTap: (product) => _showProductDetailsSheet(context, product),
        ),
        Positioned(
          top: 14,
          right: 10,
          // bottom: 20,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop(); // Close the bottom sheet
            },
          ),
        ),
      ],
    );

    if (isLargeScreen) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('${category.name} Products')),
          body: content,
        ),
      ));
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, controller) => content,
        ),
      );
    }
  }

  void _showProductDetailsSheet(BuildContext context, Product product) {
    showProductDetailsSheet(
      context,
      product,
      onDelete: () {
        setState(() {
          products.remove(product);
          productsByCategory = organizeProductsByCategory();
        });
        Navigator.pop(context);
      },
      onEdit: (editedProduct) {
        setState(() {
          int index = products.indexWhere((p) => p.id == editedProduct.id);
          if (index != -1) {
            products[index] = editedProduct;
            productsByCategory = organizeProductsByCategory();
          }
        });
        Navigator.pop(context);
      },
      onUpdateProduct: (updatedProduct) {
        setState(() {
          int index = products.indexWhere((p) => p.id == updatedProduct.id);
          if (index != -1) {
            products[index] = updatedProduct;
            productsByCategory = organizeProductsByCategory();
          }
        });
      },
      categoryId: product.categoryId,
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool showShadow;
  final int productCount;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    this.showShadow = false,
    required this.productCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = _getCategoryStyle(category.name);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: style['colors'] as List<Color>,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: (style['colors'] as List<Color>)[0].withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  style['icon'] as IconData,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$productCount items',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getCategoryStyle(String categoryName) {
    // Debug print to see actual category names
    print('Category name: $categoryName');

    String normalizedName = categoryName.toLowerCase().trim();

    // Map specific category names to style keys
    final Map<String, Map<String, dynamic>> categoryMapping = {
      'home & kitchen': {
        'icon': Icons.kitchen,
        'colors': [Color(0xFF9B5DE5), Color(0xFF7209B7)],
      },
      'car accessories': {
        'icon': Icons.car_repair,
        'colors': [Color(0xFF90CAF9), Color(0xFF1976D2)],
      },
      'sports & fitness': {
        'icon': Icons.fitness_center,
        'colors': [Color(0xFF4CC9F0), Color(0xFF4361EE)],
      },
      'automotive': {
        'icon': Icons.directions_car,
        'colors': [Color(0xFF64B5F6), Color(0xFF0D47A1)],
      },
      'furniture': {
        'icon': Icons.chair,
        'colors': [Color(0xFFB39DDB), Color(0xFF673AB7)],
      },
      'electronics': {
        'icon': Icons.devices,
        'colors': [Color(0xFF6C7FD8), Color(0xFF5163B3)],
      },
      'clothing': {
        'icon': Icons.checkroom,
        'colors': [Color(0xFFFF8C82), Color(0xFFE5484D)],
      },
      'groceries': {
        'icon': Icons.shopping_basket,
        'colors': [Color(0xFFAED581), Color(0xFF689F38)],
      },
      'books': {
        'icon': Icons.menu_book,
        'colors': [Color(0xFFF4A261), Color(0xFFE76F51)],
      },
      'toys': {
        'icon': Icons.toys,
        'colors': [Color(0xFFFED766), Color(0xFFFF9E00)],
      },
    };

    // Get the style directly from mapping or use a default with a unique color
    final style = categoryMapping[normalizedName] ??
        {
          'icon': Icons.category,
          'colors': [
            Color(0xFF757575), // Primary gray
            Color(0xFF616161), // Darker gray
          ],
        };

    // Debug print the result
    print('Style found: ${categoryMapping.containsKey(normalizedName)}');

    return style;
  }
}

class CategoryTile extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final int productCount;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
    required this.productCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      leading: Icon(category.icon),
      trailing: Text('$productCount products'),
      onTap: onTap,
    );
  }
}

class ProductListView extends StatefulWidget {
  final Category category;
  final List<Product> products;
  final Function(Product) onProductTap;

  const ProductListView({
    Key? key,
    required this.category,
    required this.products,
    required this.onProductTap,
  }) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<Product> filteredProducts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.products.length > 5)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.indigo),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(context, filteredProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => widget.onProductTap(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.quantityLeft > 0
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Qty: ${product.quantityLeft}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: product.quantityLeft > 0
                                  ? Colors.green
                                  : Colors.red,
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
}
