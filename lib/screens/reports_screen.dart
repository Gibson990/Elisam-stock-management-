import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 800) {
                    // Large screen layout
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
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
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                              decoration: InputDecoration(
                                labelText: 'Search Reports',
                                labelStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Search by date, product...',
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
                                  borderSide: BorderSide(
                                      color: Colors.grey[200]!, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.indigo[300]!, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Container(
                          width: 180,
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
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select Date',
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'YYYY-MM-DD',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.indigo[400],
                                size: 22,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey[200]!, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.indigo[300]!, width: 1.5),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade500,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Add New Sale',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.amber.shade600,
                                Colors.amber.shade500,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Export Report',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Small screen layout
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
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
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                            decoration: InputDecoration(
                              labelText: 'Search Reports',
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Search by date, product...',
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
                                borderSide: BorderSide(
                                    color: Colors.grey[200]!, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.indigo[300]!, width: 1.5),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
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
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                            decoration: InputDecoration(
                              labelText: 'Select Date',
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'YYYY-MM-DD',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.indigo[400],
                                size: 22,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey[200]!, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.indigo[300]!, width: 1.5),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.green.shade600,
                                      Colors.green.shade500,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Add New Sale',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.amber.shade600,
                                      Colors.amber.shade500,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.download, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Export Report',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth > 600
                            ? (constraints.maxWidth - 40) / 3
                            : constraints.maxWidth,
                        child: _buildInfoCard('Total Products', '500'),
                      ),
                      SizedBox(
                        width: constraints.maxWidth > 600
                            ? (constraints.maxWidth - 40) / 3
                            : constraints.maxWidth,
                        child: _buildInfoCard('Total Categories', '10'),
                      ),
                      SizedBox(
                        width: constraints.maxWidth > 600
                            ? (constraints.maxWidth - 40) / 3
                            : constraints.maxWidth,
                        child: _buildInfoCard('Total Today Sales', '\$100,000'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildSalesTable(),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      children: [
                        Expanded(child: _buildSalesDataChart()),
                        const SizedBox(width: 16),
                        Expanded(child: _buildRevenueTrendsChart()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildSalesDataChart(),
                        const SizedBox(height: 16),
                        _buildRevenueTrendsChart(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.withOpacity(0.8),
            Colors.indigo.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    letterSpacing: 0.3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconForTitle(title),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            _buildGrowthIndicator(title),
          ],
        ),
      ),
    );
  }

  // Helper method to get appropriate icon for each card
  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Total Products':
        return Icons.inventory;
      case 'Total Categories':
        return Icons.category;
      case 'Total Today Sales':
        return Icons.attach_money;
      default:
        return Icons.info;
    }
  }

  // Helper method to build growth indicator
  Widget _buildGrowthIndicator(String title) {
    // You can make this dynamic based on actual data
    const isPositive = true;
    const percentage = '12%';

    return Row(
      children: [
        Icon(
          isPositive ? Icons.trending_up : Icons.trending_down,
          color: Colors.white.withOpacity(0.9),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$percentage from last month',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSalesTable() {
    return Center(
      child: Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 1200,
              maxWidth: 1400,
            ),
            child: DataTable(
              columnSpacing: 30,
              columns: const [
                DataColumn(
                  label: Expanded(
                    flex: 50,
                    child: Text('Product Name', textAlign: TextAlign.left),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Daily Sales', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Weekly Sales', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Monthly Sales', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Total Sales', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Revenue', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Actions', textAlign: TextAlign.center),
                  ),
                ),
              ],
              rows: [
                _buildDataRow(
                  'Long Product Name A for Testing Purposes with Extended Description',
                  '50',
                  '300',
                  '1200',
                  '5000',
                  '\$15,000',
                ),
                _buildDataRow(
                  'Extended Product B with Extra Description',
                  '30',
                  '180',
                  '800',
                  '3000',
                  '\$9,000',
                ),
                _buildDataRow(
                  'Comprehensive Product C with Additional Details',
                  '70',
                  '420',
                  '1800',
                  '7000',
                  '\$21,000',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(String product, String dailySales, String weeklySales,
      String monthlySales, String totalSales, String revenue) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 480,
            child: Text(
              product,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(dailySales),
        )),
        DataCell(Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(weeklySales),
        )),
        DataCell(Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(monthlySales),
        )),
        DataCell(Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(totalSales),
        )),
        DataCell(Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(revenue),
        )),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.indigo),
                onPressed: () {},
                iconSize: 20,
                padding: const EdgeInsets.all(4),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
                iconSize: 20,
                padding: const EdgeInsets.all(4),
              ),
              IconButton(
                icon: const Icon(Icons.download, color: Colors.green),
                onPressed: () {},
                iconSize: 20,
                padding: const EdgeInsets.all(4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSalesDataChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sales Data',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Daily',
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Colors.grey[600]),
                    isDense: true,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                      DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                      DropdownMenuItem(
                          value: 'Monthly', child: Text('Monthly')),
                      DropdownMenuItem(
                          value: 'Annually', child: Text('Annually')),
                    ],
                    onChanged: (String? value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20000,
                  minY: 0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String formattedValue =
                            rod.toY.toStringAsFixed(0).padLeft(5, '0');
                        return BarTooltipItem(
                          '\$$formattedValue',
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.left,
                          children: const [],
                        );
                      },
                      tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      tooltipMargin: 8,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              titles[value.toInt()],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          String formattedValue =
                              value.toInt().toString().padLeft(5, '0');
                          return Text(
                            '\$$formattedValue',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          );
                        },
                        reservedSize: 60,
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.15),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _createBarGroup(0, 15000),
                    _createBarGroup(1, 8000),
                    _createBarGroup(2, 12000),
                    _createBarGroup(3, 17000),
                    _createBarGroup(4, 10000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create bar groups
  BarChartGroupData _createBarGroup(int x, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: Colors.indigo,
          width: 20,
          borderRadius: BorderRadius.circular(2),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20000,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueTrendsChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Revenue Trends',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Daily',
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Colors.grey[600]),
                    isDense: true,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                      DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                      DropdownMenuItem(
                          value: 'Monthly', child: Text('Monthly')),
                      DropdownMenuItem(
                          value: 'Annually', child: Text('Annually')),
                    ],
                    onChanged: (String? value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          String formattedValue =
                              barSpot.y.toStringAsFixed(0).padLeft(5, '0');
                          return LineTooltipItem(
                            '\$$formattedValue',
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.left,
                            children: const [],
                          );
                        }).toList();
                      },
                      tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      tooltipMargin: 8,
                    ),
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: Colors.indigo.withOpacity(0.3),
                            strokeWidth: 2,
                          ),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: Colors.indigo,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? lineTouch) {
                      // Handle touch events if needed
                    },
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 5000,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.15),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.15),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                          if (value.toInt() < titles.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                titles[value.toInt()],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          String formattedValue =
                              value.toInt().toString().padLeft(5, '0');
                          return SizedBox(
                            width: 60, // Fixed width for consistency
                            child: Text(
                              '\$$formattedValue',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              textAlign:
                                  TextAlign.right, // Right align the text
                            ),
                          );
                        },
                        reservedSize:
                            60, // Increased to accommodate the fixed width
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 4,
                  minY: 0,
                  maxY: 20000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 12000),
                        FlSpot(1, 8000),
                        FlSpot(2, 16000),
                        FlSpot(3, 14000),
                        FlSpot(4, 18000),
                      ],
                      isCurved: true,
                      color: Colors.indigo,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.indigo,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo.withOpacity(0.25),
                            Colors.indigo.withOpacity(0.05),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
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

  Widget _buildButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add New Sale'),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Export Report'),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom tooltip widget
class CustomTooltip extends StatelessWidget {
  final String value;

  const CustomTooltip({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade100,
            Colors.white.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.indigo.shade700,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
