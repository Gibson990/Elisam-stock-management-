import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.add),
        label: Text('Add Product'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.zero,
              ),
        ),
      ),
    );
  }
}
