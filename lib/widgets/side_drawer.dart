import 'package:flutter/material.dart';
import 'drawer_list.dart'; // Ensure you import your DrawerListItem if it's separate

class CustomDrawer extends StatelessWidget {
  final int selectedPageIndex;
  final Function(int) onSelectPage;

  const CustomDrawer({
    Key? key,
    required this.selectedPageIndex,
    required this.onSelectPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    child: Image.asset(
                      'assets/company_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to Elisam System',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerListItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  isSelected: selectedPageIndex == 0,
                  onTap: () {
                    if (selectedPageIndex != 0) {
                      onSelectPage(0); // Update selected page index
                    }
                  },
                ),
                DrawerListItem(
                  icon: Icons.category,
                  title: 'Categories',
                  isSelected: selectedPageIndex == 1,
                  onTap: () {
                    if (selectedPageIndex != 1) {
                      onSelectPage(1); // Update selected page index
                    }
                  },
                ),
                DrawerListItem(
                  icon: Icons.inventory,
                  title: 'Products',
                  isSelected: selectedPageIndex == 2,
                  onTap: () {
                    if (selectedPageIndex != 2) {
                      onSelectPage(2); // Update selected page index
                    }
                  },
                ),
                DrawerListItem(
                  icon: Icons.shopping_cart,
                  title: 'Sales',
                  isSelected: selectedPageIndex == 3,
                  onTap: () {
                    if (selectedPageIndex != 3) {
                      onSelectPage(3); // Update selected page index
                    }
                  },
                ),
                DrawerListItem(
                  icon: Icons.report,
                  title: 'Reports',
                  isSelected: selectedPageIndex == 4,
                  onTap: () {
                    if (selectedPageIndex != 4) {
                      onSelectPage(4); // Update selected page index
                    }
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(height: 10), // Add space above the logout button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red), // Red outline border
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading:
                  Icon(Icons.exit_to_app, color: Colors.red), // Red logout icon
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Add logout logic here
              },
            ),
          ),
          SizedBox(height: 10), // Add space below the logout button
        ],
      ),
    );
  }
}
