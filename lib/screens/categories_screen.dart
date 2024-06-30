import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  // Example list of categories (replace with your actual data)
  final List<Category> categories = [
    Category(name: 'Electronics', icon: Icons.devices),
    Category(name: 'Clothing', icon: Icons.shopping_bag),
    Category(name: 'Books', icon: Icons.menu_book),
    Category(name: 'Home Appliances', icon: Icons.home),
    Category(name: 'Toys', icon: Icons.toys),
    Category(name: 'Sports', icon: Icons.sports_soccer),
    Category(name: 'Beauty', icon: Icons.face),
    Category(name: 'Furniture', icon: Icons.weekend),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // For desktop layout
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.5, // Aspect ratio for grid items
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categories[index],
                  onTap: () {
                    // Implement navigation logic or actions when a category is tapped
                  },
                  showShadow: true, // Enable shadow for desktop
                );
              },
            );
          } else {
            // For mobile layout
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryTile(
                  category: categories[index],
                  onTap: () {
                    // Implement navigation logic or actions when a category is tapped
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool showShadow;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    this.showShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: showShadow ? 4 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 10),
              Text(
                category.name,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      leading: Icon(category.icon),
      onTap: onTap,
    );
  }
}
