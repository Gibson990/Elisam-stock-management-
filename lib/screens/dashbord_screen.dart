import 'package:elisam_store_management/models/sale.dart';
import 'package:flutter/material.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key, required List<Sale> sales});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashbordScreen> {
  // Initial selected filter
  String selectedSalesRange = 'Today'; // Default range
  String totalSalesValue = '\$100,000'; // Default sales value

  // Dropdown options
  final List<String> salesRangeOptions = [
    'Today',
    'Weekly',
    'Monthly',
    'Semi-Annually',
    'Annually',
  ];

  // Simulate fetching sales data based on the selected range
  void updateSalesData(String range) {
    setState(() {
      selectedSalesRange = range;
      switch (range) {
        case 'Today':
          totalSalesValue = '\$100,000'; // Replace with actual daily sales data
          break;
        case 'Weekly':
          totalSalesValue =
              '\$500,000'; // Replace with actual weekly sales data
          break;
        case 'Monthly':
          totalSalesValue =
              '\$2,000,000'; // Replace with actual monthly sales data
          break;
        case 'Semi-Annually':
          totalSalesValue =
              '\$10,000,000'; // Replace with actual semi-annual sales data
          break;
        case 'Annually':
          totalSalesValue =
              '\$20,000,000'; // Replace with actual annual sales data
          break;
        default:
          totalSalesValue = '\$100,000';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50], // Light background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Increased padding
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isDesktop = constraints.maxWidth > 600;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Modern Dropdown
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedSalesRange,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 22,
                            color: Colors.grey[600],
                          ),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          items: salesRangeOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              updateSalesData(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Image container with shadow
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias, // For rounded corners
                    child: Image.asset(
                      'assets/welcome_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Cards Section
                  isDesktop ? _buildDesktopCards() : _buildMobileCards(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildCard(
          'Total Products',
          '500',
          Icons.storage,
          [Colors.blue.shade400, Colors.blue.shade600],
        ),
        const SizedBox(width: 20),
        _buildCard(
          'Total Categories',
          '10',
          Icons.category,
          [Colors.purple.shade400, Colors.purple.shade600],
        ),
        const SizedBox(width: 20),
        _buildCard(
          'Total ${selectedSalesRange.toLowerCase()} Sales',
          totalSalesValue,
          Icons.attach_money,
          [Colors.green.shade400, Colors.green.shade600],
        ),
      ],
    );
  }

  Widget _buildMobileCards() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCard(
              'Total Products',
              '500',
              Icons.storage,
              [Colors.blue.shade400, Colors.blue.shade600],
            ),
            const SizedBox(height: 20),
            _buildCard(
              'Total Categories',
              '10',
              Icons.category,
              [Colors.purple.shade400, Colors.purple.shade600],
            ),
            const SizedBox(height: 20),
            _buildCard(
              'Total ${selectedSalesRange.toLowerCase()} Sales',
              totalSalesValue,
              Icons.attach_money,
              [Colors.green.shade400, Colors.green.shade600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, String value, IconData icon, List<Color> gradientColors) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
