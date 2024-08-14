part of 'product_bloc_bloc.dart';

sealed class ProductBlocEvent extends Equatable {
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductBlocEvent {}

class GetSingleProductEvent extends ProductBlocEvent {
  final int productId;

  GetSingleProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateProductEvent extends ProductBlocEvent {
  final Product updatedProduct;

  UpdateProductEvent(this.updatedProduct);

  @override
  List<Object> get props => [updatedProduct];
}

class DeleteProductEvent extends ProductBlocEvent {
  final int productId;

  DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CreateProductEvent extends ProductBlocEvent {
  final Product newProduct;

  CreateProductEvent(this.newProduct);

  @override
  List<Object> get props => [newProduct];
}