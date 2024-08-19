import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/details_card.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product, required id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          style: const ButtonStyle(
            shape: WidgetStatePropertyAll(
              CircleBorder(
                eccentricity: BorderSide.strokeAlignCenter,
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
        ),
      ),
      body: Column(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DetailsCard(product: product),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 152,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromRGBO(255, 19, 19, 0.79),
                              side: const BorderSide(
                                color: Color.fromRGBO(255, 19, 19, 0.79),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(DeleteProductEvent(product.id));
                            },
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 19, 19, 0.79),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 152,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(63, 81, 243, 1),
                              foregroundColor: Colors.white,
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/update',
                                arguments:
                                    product, // Pass the product as an argument
                              );
                            },
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
