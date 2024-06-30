import 'package:flutter/material.dart';
import 'package:elisam_store_management/screens/dashbord_screen.dart';
import 'package:elisam_store_management/screens/categories_screen.dart';
import 'package:elisam_store_management/screens/products_screen.dart';
import 'package:elisam_store_management/screens/sales_screen.dart';
import 'package:elisam_store_management/screens/reports_screen.dart';
import 'package:elisam_store_management/widgets/side_drawer.dart';

void main() {
  runApp(ElisamApp());
}

class ElisamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elisam',
      theme: ThemeData(
        primaryColor: Colors.indigo, // Apple iOS Blue
        hintColor: const Color(0xFFFF2D55), // Apple iOS Red
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardWrapper(),
        '/categories': (context) =>
            ScreenWrapper(screen: CategoriesScreen(), selectedPageIndex: 1),
        '/products': (context) =>
            ScreenWrapper(screen: ProductsScreen(), selectedPageIndex: 2),
        '/sales': (context) =>
            ScreenWrapper(screen: const SalesScreen(), selectedPageIndex: 3),
        '/reports': (context) =>
            ScreenWrapper(screen: const ReportsScreen(), selectedPageIndex: 4),
      },
    );
  }
}

class DashboardWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(screen: DashbordScreen(), selectedPageIndex: 0);
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
