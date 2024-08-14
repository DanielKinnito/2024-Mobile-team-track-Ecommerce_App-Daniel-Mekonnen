part of 'product_bloc_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState();
  
  @override
  List<Object> get props => [];
}

class InitialProductState extends ProductBlocState {}

class LoadingProductState extends ProductBlocState {}

class LoadedAllProductsState extends ProductBlocState {
  final List<Product> products;

  LoadedAllProductsState(this.products);

  @override
  List<Object> get props => [products];
}

class LoadedSingleProductState extends ProductBlocState {
  final Product product;

  LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

class ErrorProductState extends ProductBlocState {
  final String message;

  ErrorProductState(this.message);

  @override
  List<Object> get props => [message];
}