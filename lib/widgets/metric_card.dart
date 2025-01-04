import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(context).primaryColor, // Use theme primary color
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color:
                    Theme.of(context).primaryColor, // Use theme primary color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
