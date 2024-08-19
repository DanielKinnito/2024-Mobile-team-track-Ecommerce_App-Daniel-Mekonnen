import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/image_upload_widget.dart';

class ProductAddPage extends StatefulWidget {
  final Product? product;

  const ProductAddPage({super.key, this.product});

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.product != null ) {
      _name.text = widget.product!.name;
      _description.text = widget.product!.description;
      _price.text = widget.product!.price.toString();
      _selectedImage = File(widget.product!.imageUrl);
    }
  }

  void _handleImagePicked(File imageFile) {
    setState(() {
      _selectedImage = imageFile;
    });
  }

  void _submitProduct() {
    if (_name.text.isEmpty ||
        _description.text.isEmpty ||
        _price.text.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select an image')),
      );
      
    }

    final product = ProductModel(
      id: widget.product?.id ?? '',
      name: _name.text,
      description: _description.text,
      price: double.parse(_price.text),
      imageUrl: _selectedImage!.path,
    );

    BlocProvider.of<ProductBloc>(context).add(
      CreateProductEvent(product, _selectedImage!.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getAllProducts: sl(),
        getProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
        insertProduct: sl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Color.fromARGB(255, 54, 104, 255), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is AddPageSubmittedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added successfully')),
              );
              context.read<ProductBloc>().add(LoadAllProductEvent());
              Navigator.pushNamed(context, '/');
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
                    controller: _name,
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  const Text('Price', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixText: '\$',
                      suffixStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _description,
                    maxLines: 6,
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // AddButton(
                  //   nameController: _name,
                  //   priceController: _price,
                  //   descriptionController: _description,
                  //   selectedImage: _selectedImage,
                  // ),
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
                      onPressed: _submitProduct,
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}