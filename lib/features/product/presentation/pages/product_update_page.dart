import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class ProductUpdatePage extends StatefulWidget {
  final Product product;

  const ProductUpdatePage({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductUpdatePageState createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.product.name);
    _description = TextEditingController(text: widget.product.description);
    _price = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 54, 104, 255),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Update Product',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is UpdatePageSubmittedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product updated successfully')),
            );
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else if (state is DeletedProductState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product deleted successfully')),
            );
            Navigator.popUntil(context, ModalRoute.withName('/'));
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
                const Text('Price', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
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
                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _description,
                  maxLines: 4,
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final name = _name.text;
                        final description = _description.text;
                        final price = double.tryParse(_price.text);
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

                        final updatedProduct = ProductModel(
                          id: widget.product?.id ?? '',
                          name: name,
                          description: description,
                          price: price,
                          imageUrl: widget.product.imageUrl,
                        );

                        BlocProvider.of<ProductBloc>(context).add(
                          UpdateProductEvent(updatedProduct),
                        );
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Product Updated successfully')),
                        );
                        // Navigate to home page and refresh it
                        Navigator.popUntil(
                            context, ModalRoute.withName('/home'));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 54, 104, 255),
                      ),
                      child: const Text('Update Product',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(DeleteProductEvent(widget.product.id));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Delete Product'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
