import 'package:flutter/material.dart';
import 'package:elisam_store_management/models/product.dart';
import 'package:elisam_store_management/screens/edit_product_screen.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ProductDetailsSheet extends StatelessWidget {
  final Product product;
  final Function() onDelete;
  final Function(Product editedProduct) onEdit;
  final Function(Product updatedProduct) onUpdateProduct;

  final String categoryId;

  const ProductDetailsSheet({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
    required this.onUpdateProduct,
    required this.categoryId, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return isLargeScreen
        ? Center(
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                children: [
                  _buildLargeScreenContent(context),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: _buildSmallScreenContent(context),
          );
  }

  Widget _buildLargeScreenContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Product Details',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${product.name}',
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Price: ${product.price}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Quantity Left: ${product.quantityLeft}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Description: ${product.description}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: product.barcodes.isEmpty ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Barcode: ${product.barcodes.isEmpty ? 'Not generated' : 'Generated'}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () => _generateBarcodes(context),
                  child: const Text(
                    'Generate Barcodes',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
                IconButton(
                  onPressed: () => _navigateToEditProduct(context),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Product Details',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Name: ${product.name}',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Price: ${product.price}',
            style: const TextStyle(fontSize: 16.0, color: Colors.green),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Quantity Left: ${product.quantityLeft}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Description: ${product.description}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: product.barcodes.isEmpty ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Barcode: ${product.barcodes.isEmpty ? 'Not generated' : 'Generated'}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () => _generateBarcodes(context),
                  child: const Text(
                    'Generate Barcodes',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
                IconButton(
                  onPressed: () => _navigateToEditProduct(context),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEditProduct(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: product,
          categoryId: categoryId, // Pass categoryId here
          Categories: const [], // Adjust if needed
        ),
      ),
    ).then((editedProduct) {
      if (editedProduct != null) {
        onEdit(editedProduct);
      }
    });
  }

  Future<void> _generateBarcodes(BuildContext context) async {
    final pdf = pw.Document();
    final barcode = Barcode.code128();
    final int totalBarcodes = product.quantityLeft;
    const int barcodesPerPage = 10;
    final int pagesNeeded = (totalBarcodes / barcodesPerPage).ceil();

    List<String> generatedBarcodes = [];

    for (int pageNum = 0; pageNum < pagesNeeded; pageNum++) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 20),
                pw.Text(
                  product.name,
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Expanded(
                  child: pw.GridView(
                    crossAxisCount: 2,
                    children: List.generate(barcodesPerPage, (index) {
                      final barcodeNum = pageNum * barcodesPerPage + index;
                      if (barcodeNum < totalBarcodes) {
                        final barcodeData = '${product.id}-${barcodeNum + 1}';
                        generatedBarcodes.add(barcodeData);
                        return pw.Center(
                          child: pw.BarcodeWidget(
                            barcode: barcode,
                            data: barcodeData,
                            width: 150,
                            height: 60,
                          ),
                        );
                      } else {
                        return pw.Container();
                      }
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/barcodes.pdf");
    await file.writeAsBytes(await pdf.save());

    final updatedProduct = Product(
      id: product.id,
      name: product.name,
      price: product.price,
      quantityLeft: product.quantityLeft,
      description: product.description,
      category: product.category,
      imageUrl: product.imageUrl,
      barcodes: generatedBarcodes,
      categoryId: product.categoryId, // Make sure to set the correct categoryId
    );

    onUpdateProduct(updatedProduct);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Barcodes generated and saved to ${file.path}'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () => _openPdf(file.path),
        ),
      ),
    );
  }

  Future<void> _openPdf(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Error opening PDF: ${result.message}");
      }
    } catch (e) {
      print("Error opening PDF: $e");
    }
  }
}

void showProductDetailsSheet(
  BuildContext context,
  Product product, {
  required String categoryId, // Add this line
  required Function() onDelete,
  required Function(Product) onEdit,
  required Function(Product) onUpdateProduct,
}) {
  final isLargeScreen = MediaQuery.of(context).size.width > 600;

  if (isLargeScreen) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.transparent,
          child: ProductDetailsSheet(
            product: product,
            onDelete: onDelete,
            onEdit: onEdit,
            onUpdateProduct: onUpdateProduct,
            categoryId: categoryId, // Pass categoryId here
          ),
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ProductDetailsSheet(
          product: product,
          onDelete: onDelete,
          onEdit: onEdit,
          onUpdateProduct: onUpdateProduct,
          categoryId: categoryId, // Pass categoryId here
        );
      },
    );
  }
}
