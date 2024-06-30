import 'package:elisam_store_management/widgets/side_drawer.dart';
import 'package:flutter/material.dart';

class DashbordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        selectedPageIndex: 0, // Initial selected page index (Dashboard)
        onSelectPage: (int) {
          switch (int) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/categories');
              break;
            case 2:
              Navigator.pushNamed(context, '/products');
              break;
            case 3:
              Navigator.pushNamed(context, '/sales');
              break;
            case 4:
              Navigator.pushNamed(context, '/reports');
              break;
            default:
          }
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isDesktop = constraints.maxWidth > 600;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 200,
                    child: Image.asset(
                      'assets/welcome_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to the Elisam Stock Management System',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  isDesktop
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StockSummaryCard(
                              title: 'Total Products',
                              value: '500', // Replace with actual data
                              icon: Icons.storage,
                              isDesktop: isDesktop,
                            ),
                            const SizedBox(width: 12),
                            StockSummaryCard(
                              title: 'Total Categories',
                              value: '10', // Replace with actual data
                              icon: Icons.category,
                              isDesktop: isDesktop,
                            ),
                            const SizedBox(width: 12),
                            StockSummaryCard(
                              title: 'Total Sales',
                              value: '\$100,000', // Replace with actual data
                              icon: Icons.attach_money,
                              isDesktop: isDesktop,
                            ),
                          ],
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                StockSummaryCardAlt(
                                  title: 'Total Products',
                                  value: '500', // Replace with actual data
                                  icon: Icons.storage,
                                  isDesktop: isDesktop,
                                ),
                                const SizedBox(height: 12),
                                StockSummaryCardAlt(
                                  title: 'Total Categories',
                                  value: '10', // Replace with actual data
                                  icon: Icons.category,
                                  isDesktop: isDesktop,
                                ),
                                const SizedBox(height: 12),
                                StockSummaryCardAlt(
                                  title: 'Total Sales',
                                  value:
                                      '\$100,000', // Replace with actual data
                                  icon: Icons.attach_money,
                                  isDesktop: isDesktop,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class StockSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isDesktop;

  const StockSummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDesktop ? 160 : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null && isDesktop)
                Icon(icon, size: 24, color: Theme.of(context).primaryColor),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StockSummaryCardAlt extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isDesktop;

  const StockSummaryCardAlt({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              if (icon != null && isDesktop)
                Icon(icon, size: 24, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                      ),
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
}
