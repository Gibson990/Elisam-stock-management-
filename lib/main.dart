import 'package:flutter/material.dart';
import 'package:elisam_store_management/screens/dashbord_screen.dart';
import 'package:elisam_store_management/screens/categories_screen.dart';
import 'package:elisam_store_management/screens/products_screen.dart';
import 'package:elisam_store_management/screens/sales_screen.dart';
import 'package:elisam_store_management/screens/reports_screen.dart';
import 'package:elisam_store_management/widgets/side_drawer.dart';
import 'package:elisam_store_management/models/sale.dart';

void main() {
  runApp(ElisamApp());
}

class ElisamApp extends StatefulWidget {
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
        '/categories': (context) => ScreenWrapper(
              screen: CategoriesScreen(),
              selectedPageIndex: 1,
            ),
        '/products': (context) => const ScreenWrapper(
              screen: ProductsScreen(),
              selectedPageIndex: 2,
            ),
        '/sales': (context) => ScreenWrapper(
              screen: SalesScreen(),
              selectedPageIndex: 3,
            ),
        '/reports': (context) => ScreenWrapper(
              screen: ReportScreen(),
              selectedPageIndex: 4,
            ),
      },
    );
  }
}

class DashboardWrapper extends StatelessWidget {
  final List<Sale> sales;

  const DashboardWrapper({Key? key, required this.sales}) : super(key: key);

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

  const ScreenWrapper({required this.screen, required this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elisam'),
      ),
      drawer: CustomDrawer(
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
            default:
              break;
          }
        },
      ),
      body: screen,
    );
  }
}
