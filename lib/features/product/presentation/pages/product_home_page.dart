import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/product_card.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/icon_button_with_bg.dart';

class ProductHomePage extends StatelessWidget {
  const ProductHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8.0),
    
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        title: const AppBarTitle(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButtonWithBg(
              icon: Icons.notifications_outlined,
              onPressed: () {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
        onPressed: () {
          Navigator.pushNamed(context, 'Add/Update');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Available Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomIconButton(
                  icon: Icons.search_rounded,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Search');
                  },
                ),
              ],
            ),
            SingleChildScrollView(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadingProductState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoadedAllProductsState) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(GetSingleProductEvent(product.id));
                            Navigator.pushNamed(context, 'Details',
                                arguments: product);
                          },
                        );
                      },
                    );
                  } else if (state is ErrorProductState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No products available.'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
