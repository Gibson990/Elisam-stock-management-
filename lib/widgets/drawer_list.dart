import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final Function onTap;

  const DrawerListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.blue,
        ),
      ),
      onTap: () => onTap(), // Invoke onTap function when tapped
    );
  }
}
