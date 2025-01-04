import 'package:flutter/material.dart';
import 'package:elisam_store_management/screens/dashbord_screen.dart';
import 'package:elisam_store_management/screens/categories_screen.dart';
import 'package:elisam_store_management/screens/products_screen.dart';
import 'package:elisam_store_management/screens/sales_screen.dart';
import 'package:elisam_store_management/screens/reports_screen.dart';
import 'package:elisam_store_management/widgets/side_drawer.dart';
import 'package:elisam_store_management/models/sale.dart';

void main() {
  runApp(const ElisamApp());
}

class ElisamApp extends StatefulWidget {
  const ElisamApp({super.key});

  @override
  _ElisamAppState createState() => _ElisamAppState();
}

class _ElisamAppState extends State<ElisamApp> {
  List<Sale> sales = []; // Initialize your sales list

  void addSale(Sale sale) {
    setState(() {
      sales.add(sale); // Add sale and trigger UI update
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elisam',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        hintColor: const Color(0xFFFF2D55),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardWrapper(sales: sales),
        '/categories': (context) => const ScreenWrapper(
              screen: CategoriesScreen(),
              selectedPageIndex: 1,
            ),
        '/products': (context) => const ScreenWrapper(
              screen: ProductsScreen(),
              selectedPageIndex: 2,
            ),
        '/sales': (context) => ScreenWrapper(
              screen: SalesScreen(key: SalesScreen.globalKey),
              selectedPageIndex: 3,
            ),
        '/reports': (context) => const ScreenWrapper(
              screen: ReportScreen(),
              selectedPageIndex: 4,
            ),
      },
    );
  }
}

class DashboardWrapper extends StatelessWidget {
  final List<Sale> sales;

  const DashboardWrapper({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: DashbordScreen(sales: sales),
      selectedPageIndex: 0,
    );
  }
}

class ScreenWrapper extends StatelessWidget {
  final Widget screen;
  final int selectedPageIndex;

  const ScreenWrapper(
      {super.key, required this.screen, required this.selectedPageIndex});

  String _getScreenTitle() {
    switch (selectedPageIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Categories';
      case 2:
        return 'Products';
      case 3:
        return 'Sales';
      case 4:
        return 'Reports';
      default:
        return 'Elisam';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey[800]),
              title: Text(
                _getScreenTitle(),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                if (selectedPageIndex ==
                    3) // Show cart icon only on sales screen
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.indigo,
                        ),
                        onPressed: () {
                          final state = SalesScreen.globalKey.currentState;
                          if (state != null) {
                            state.showCartModal(context);
                          }
                        },
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: SalesScreen.cartItemCountNotifier,
                        builder: (context, count, _) {
                          return count > 0
                              ? Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '$count',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.indigo,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.indigo,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
              ],
            ),
      drawer: !isDesktop
          ? CustomDrawer(
              selectedPageIndex: selectedPageIndex,
              onSelectPage: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacementNamed(context, '/');
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(context, '/categories');
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(context, '/products');
                    break;
                  case 3:
                    Navigator.pushReplacementNamed(context, '/sales');
                    break;
                  case 4:
                    Navigator.pushReplacementNamed(context, '/reports');
                    break;
                }
              },
            )
          : null,
      body: Row(
        children: [
          if (isDesktop)
            CustomDrawer(
              selectedPageIndex: selectedPageIndex,
              onSelectPage: (index) {
                if (index == -2) {
                  // Handle logout
                  return;
                }
                switch (index) {
                  case 0:
                    Navigator.pushReplacementNamed(context, '/');
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(context, '/categories');
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(context, '/products');
                    break;
                  case 3:
                    Navigator.pushReplacementNamed(context, '/sales');
                    break;
                  case 4:
                    Navigator.pushReplacementNamed(context, '/reports');
                    break;
                }
              },
            ),
          Expanded(
            child: Column(
              children: [
                if (isDesktop)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getScreenTitle(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.account_circle_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                Expanded(child: screen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
