import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
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
