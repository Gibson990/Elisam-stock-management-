import 'package:flutter/material.dart';
import 'category.dart';

class Categories {
  static final List<Category> list = [
    Category(id: '1', name: 'Electronics', icon: Icons.electrical_services),
    Category(id: '2', name: 'Clothing', icon: Icons.checkroom),
    Category(id: '3', name: 'Groceries', icon: Icons.local_grocery_store),
    Category(id: '4', name: 'Sports & Fitness', icon: Icons.fitness_center),
    Category(id: '5', name: 'Books', icon: Icons.book),
    Category(id: '6', name: 'Home & Kitchen', icon: Icons.kitchen),
    Category(id: '7', name: 'Toys', icon: Icons.toys),
    Category(id: '8', name: 'Furniture', icon: Icons.weekend),
    Category(id: '9', name: 'Automotive', icon: Icons.directions_car),
    Category(id: '10', name: 'Car Accessories', icon: Icons.car_repair),
    Category(id: '11', name: 'Car Electronics', icon: Icons.electrical_services),
    Category(id: '12', name: 'Car Parts', icon: Icons.car_rental),
    Category(id: '13', name: 'Tires & Wheels', icon: Icons.circle),
  ];

  static Category? getById(String id) {
    try {
      return list.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static Category? getByName(String name) {
    try {
      return list.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
