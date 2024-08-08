import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';

/// Abstract class defining the API for product related operations.
abstract class ProductApi {
  /// Returns a stream of all products.
  Future<Either<Failure, List<Product>>> getAllProducts();

  /// Returns a product by its ID.
  Future<Either<Failure, Product>> getProduct(String productId);

  /// Inserts a new product.
  Future<Either<Failure, void>> insertProduct(Product product);

  /// Updates an existing product.
  Future<Either<Failure, void>> updateProduct(Product product);

  /// Deletes a product by its ID.
  Future<Either<Failure, void>> deleteProduct(String productId);
}
