import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_api.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductApi productApi;
  ProductRepositoryImpl(this.productApi);

  @override
  Future<Either<Failure, Product>> getProduct(String productId) =>
      productApi.getProduct(productId);

  @override
  Future<Either<Failure, void>> insertProduct(Product product) =>
      productApi.insertProduct(product);

  @override
  Future<Either<Failure, void>> updateProduct(Product product) =>
      productApi.updateProduct(product);

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) =>
      productApi.deleteProduct(productId);

  @override
  Future<Either<Failure, List<Product>>> getAllProdcuts() =>
      productApi.getAllProducts();
}
