import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../user/domain/usecase/logout_user.dart';
import '../../../user/presentation/bloc/logout_bloc.dart';
import '../../../user/presentation/pages/login_page.dart';
import '../bloc/product_bloc.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/icon_button_with_bg.dart';
import '../widgets/product_card.dart';
import 'product_details_page.dart';

class ProductHomePage extends StatelessWidget {
  const ProductHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProductBloc(
          getAllProducts: sl(),
          getProduct: sl(),
          updateProduct: sl(),
          deleteProduct: sl(),
          insertProduct: sl(),
        );
        bloc.add(const LoadAllProductEvent());
        return bloc;
      },
      child: Scaffold(
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
                icon: Icons.logout_outlined,
                onPressed: () async {
                  LogOut(sl());
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          shape: const CircleBorder(),
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
                  const Text(
                    'Available Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomIconButton(
                    icon: Icons.search_rounded,
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is LoadingProductState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedAllProductsState) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ProductBloc>()
                              .add(const LoadAllProductEvent());
                        },
                        child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is ErrorProductState) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(
                          child: Text('Failed to load products'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
