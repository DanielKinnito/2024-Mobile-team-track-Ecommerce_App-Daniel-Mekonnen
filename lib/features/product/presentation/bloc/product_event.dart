part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductEvent {
  const LoadAllProductEvent();
}

class GetSingleProductEvent extends ProductEvent {
  final String productId;

  const GetSingleProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateProductEvent extends ProductEvent {
  final Product updatedProduct;

  const UpdateProductEvent(this.updatedProduct);

  @override
  List<Object> get props => [updatedProduct];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CreateProductEvent extends ProductEvent {
  final ProductModel product;
  final String imagePath;

  const CreateProductEvent(this.product, this.imagePath);

  @override
  List<Object> get props => [product, imagePath];

  Product? get newProduct => null;
}
class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent({required this.query});

  @override
  List<Object> get props => [query];
}
