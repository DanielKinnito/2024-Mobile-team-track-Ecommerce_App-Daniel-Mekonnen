part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadedAllProductsState extends ProductState {
  final List<Product> products;

  const LoadedAllProductsState(this.products);

  @override
  List<Object> get props => [products];
}

class LoadedSingleProductState extends ProductState {
  final Product product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

class ErrorProductState extends ProductState {
  final String message;

  const ErrorProductState(this.message);

  @override
  List<Object> get props => [message];
}

class DeletedProductState extends ProductState {
  final String productId;

  const DeletedProductState(this.productId);

  @override
  List<Object> get props => [productId];
}
