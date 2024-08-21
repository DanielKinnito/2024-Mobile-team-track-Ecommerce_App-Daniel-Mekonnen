import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/image_upload_widget.dart';

class ProductAddPage extends StatefulWidget {
  final Product? product;

  const ProductAddPage({super.key, this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _selectedImage =
          File(widget.product!.imageUrl); // Load from URL if updating
    }
  }

  void _handleImagePicked(File imageFile) {
    setState(() {
      _selectedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Color.fromARGB(255, 54, 104, 255), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.product == null ? 'Add Product' : 'Update Product',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is AddPageSubmittedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')),
            );
            // Navigate to home page and refresh it
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          } else if (state is UpdatePageSubmittedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product updated successfully')),
            );
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          } else if (state is ErrorProductState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ImageUploadWidget(
                  onImagePicked: _handleImagePicked,
                  imageFile: _selectedImage,
                ),
                const SizedBox(height: 16),
                const Text('Name', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(243, 243, 243, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Price', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(243, 243, 243, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixText: '\$',
                    suffixStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(243, 243, 243, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 54, 104, 255),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final name = _nameController.text;
                      final description = _descriptionController.text;
                      final price = double.tryParse(_priceController.text);
                      final imageUrl = _selectedImage?.path ?? '';

                      if (name.isEmpty ||
                          description.isEmpty ||
                          price == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields'),
                          ),
                        );
                        return;
                      }

                      final product = ProductModel(
                        id: widget.product?.id ?? '',
                        name: name,
                        description: description,
                        price: price,
                        imageUrl: imageUrl,
                      );

                      BlocProvider.of<ProductBloc>(context).add(
                        CreateProductEvent(product, imageUrl),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Product added successfully')),
                      );
                      // Navigate to home page and refresh it
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: Text(
                      widget.product == null ? 'ADD' : 'UPDATE',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
