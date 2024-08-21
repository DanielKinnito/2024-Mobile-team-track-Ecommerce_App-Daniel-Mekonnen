import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/insert_product.dart';
import '../../domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProduct getProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final InsertProduct insertProduct;

  List<Product> originalProducts = [];

  ProductBloc({
    required this.getAllProducts,
    required this.getProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.insertProduct,
  }) : super(ProductInitial()) {
    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingProductState());
      final productsOrFailure = await getAllProducts();
      productsOrFailure.fold(
        (failure) {
          print('Error loading products: ${failure.message}');
          emit(ErrorProductState(failure.message));
        },
        (products) {
          originalProducts = products; // Save products for search
          print('Products loaded: $products');
          emit(LoadedAllProductsState(products));
        },
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingProductState());
      final productOrFailure = await getProduct(event.productId);
      productOrFailure.fold(
        (failure) => emit(ErrorProductState(failure.message)),
        (product) => emit(LoadedSingleProductState(product)),
      );
    });

    on<CreateProductEvent>((event, emit) async {
      emit(LoadingProductState());
      try {
        final productOrFailure = await insertProduct(event.product);
        productOrFailure.fold(
          (failure) => emit(ErrorProductState(failure.message)),
          (product) => emit(LoadedSingleProductState(product)),
        );
      } on Exception catch (e) {
        emit(ErrorProductState(e.toString()));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingProductState());
      final productOrFailure = await updateProduct(event.updatedProduct);
      productOrFailure.fold(
        (failure) => emit(ErrorProductState(failure.message)),
        (product) => emit(LoadedSingleProductState(product)),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingProductState());
      final productOrFailure = await deleteProduct(event.productId);
      productOrFailure.fold(
        (failure) => emit(ErrorProductState(failure.message)),
        (productId) => emit(DeletedProductState(productId)),
      );
    });

    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onSearchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductState());

    final query = event.query.trim().toLowerCase();
    if (query.isEmpty) {
      emit(SearchPageLoadedState(products: originalProducts));
      return;
    }

    final filteredProducts = originalProducts
        .where((product) => product.name
            .trim()
            .toLowerCase()
            .contains(query))
        .toList();
    emit(SearchPageLoadedState(products: filteredProducts));
  }
}
