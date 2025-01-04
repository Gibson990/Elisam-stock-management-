import 'package:elisam_store_management/models/categories.dart';
import 'package:elisam_store_management/models/category.dart';
import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:file_picker/file_picker.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen(
      {super.key,
      required this.product,
      required List Categories,
      required String categoryId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price);
    _quantityController =
        TextEditingController(text: widget.product.quantityLeft.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _imageUrlController = TextEditingController(text: widget.product.imageUrl);

    selectedCategory = Categories.getById(widget.product.category.id) ??
        widget.product.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        setState(() {
          _imageUrlController.text = imagePath;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextField(_nameController, 'Product Name'),
                const SizedBox(height: 20.0),
                _buildTextField(_priceController, 'Price'),
                const SizedBox(height: 20.0),
                _buildTextField(_quantityController, 'Quantity Left'),
                const SizedBox(height: 20.0),
                _buildDescriptionField(_descriptionController, 'Description'),
                const SizedBox(height: 20.0),
                _buildDropdown(Categories.list, 'Category'),
                const SizedBox(height: 20.0),
                _buildTextField(_imageUrlController, 'Image URL'),
                const SizedBox(height: 20.0),
                _buildButton(
                  onPressed: _pickImage,
                  text: 'Upload Product Image',
                ),
                const SizedBox(height: 20.0),
                _buildButton(
                  onPressed: _saveChanges,
                  text: 'Save Changes',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: label == 'Price' || label == 'Quantity Left'
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      style: const TextStyle(fontSize: 16.0),
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
      style: const TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildDropdown(List<Category> items, String label) {
    return DropdownButtonFormField<Category>(
      value: selectedCategory,
      onChanged: (newValue) {
        setState(() {
          if (newValue != null) {
            selectedCategory = newValue;
          }
        });
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      items: items.map((Category category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Row(
            children: [
              Icon(category.icon),
              const SizedBox(width: 10),
              Text(category.name),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required String text}) {
    return SizedBox(
      height: 60.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    int? quantity = int.tryParse(_quantityController.text);
    if (quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid number for quantity')),
      );
      return;
    }

    final editedProduct = Product(
      id: widget.product.id,
      name: _nameController.text,
      price: _priceController.text,
      quantityLeft: quantity,
      description: _descriptionController.text,
      categoryId: selectedCategory.id, // Save the selected categoryId
      category: selectedCategory, // Also save the Category object
      imageUrl: _imageUrlController.text,
      barcodes: widget.product.barcodes,
    );

    Navigator.pop(context, editedProduct);
  }
}
