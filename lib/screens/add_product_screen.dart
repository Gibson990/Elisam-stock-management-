import 'dart:math';
import 'dart:io';
import 'package:elisam_store_management/models/category.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final List<Category> categories;
  const AddProductScreen({super.key, required this.categories});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty) {
      selectedCategory = widget.categories[0];
    }
  }

  void _pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      print('Excel file picked: ${result.files.single.name}');
    }
  }

  void _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        setState(() {
          imageUrlController.text = imagePath;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildButton(
                    onPressed: _pickExcelFile,
                    text: 'Upload Products via Excel',
                  ),
                  SizedBox(height: 20.0),
                  _buildTextField(nameController, 'Name'),
                  SizedBox(height: 20.0),
                  _buildTextField(priceController, 'Price'),
                  SizedBox(height: 20.0),
                  _buildTextField(quantityController, 'Quantity Left'),
                  SizedBox(height: 20.0),
                  _buildDescriptionField(descriptionController, 'Description'),
                  SizedBox(height: 20.0),
                  _buildDropdown(widget.categories, 'Category'),
                  SizedBox(height: 20.0),
                  _buildTextField(imageUrlController, 'Image URL'),
                  SizedBox(height: 20.0),
                  _buildButton(
                    onPressed: _pickImage,
                    text: 'Upload Product Image',
                  ),
                  SizedBox(height: 20.0),
                  _buildImagePreview(),
                  SizedBox(height: 20.0),
                  _buildButton(
                    onPressed: _addProduct,
                    text: 'Add Product',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildDescriptionField(
      TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildDropdown(List<Category> items, String label) {
    return DropdownButtonFormField<Category>(
      value: selectedCategory,
      onChanged: (Category? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      items: items.map<DropdownMenuItem<Category>>((Category category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Row(
            children: [
              Icon(category.icon),
              SizedBox(width: 10),
              Text(category.name),
            ],
          ),
        );
      }).toList(),
      hint: Text('Select a category'),
      isExpanded: true,
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required String text}) {
    return SizedBox(
      height: 60.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (imageUrlController.text.isNotEmpty) {
      return Image.file(
        File(imageUrlController.text),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }

  void _addProduct() {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select a category'),
        ),
      );
      return;
    }

    int? quantity = int.tryParse(quantityController.text);
    if (quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid number for quantity')),
      );
      return;
    }

    final newProduct = Product(
      id: _generateRandomId(),
      name: nameController.text,
      price: priceController.text,
      quantityLeft: quantity,
      description: descriptionController.text,
      category: selectedCategory!, // selected category object
      categoryId: selectedCategory!.id, // the category ID
      imageUrl: imageUrlController.text,
      barcodes: [],
    );

    Navigator.pop(context, newProduct);
  }

  static String _generateRandomId() {
    final random = Random();
    const availableChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(10,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
  }
}
