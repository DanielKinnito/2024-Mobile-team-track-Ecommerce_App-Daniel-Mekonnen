import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/product.dart';

/// A contract for interacting with the product repository.
///
/// This repository provides methods for retrieving, inserting, updating, and deleting products.
abstract class ProductRepository {
  /// Retrieves all products.
  ///
  /// Returns a [List] of [Product] objects wrapped in an [Either] indicating success or failure.
  Future<Either<Failure, List<Product>>> getAllProdcuts();

  /// Retrieves a product by its ID.
  ///
  /// Takes a [String] [productId] as a parameter and returns a [Product] object wrapped in an [Either] indicating success or failure.
  Future<Either<Failure, Product>> getProduct(String productId);

  /// Inserts a new product.
  ///
  /// Takes a [Product] object as a parameter and returns [void] wrapped in an [Either] indicating success or failure.
  Future<Either<Failure, void>> insertProduct(Product product);

  /// Updates an existing product.
  ///
  /// Takes a [Product] object as a parameter and returns [void] wrapped in an [Either] indicating success or failure.
  Future<Either<Failure, void>> updateProduct(Product product);

  /// Deletes a product by its ID.
  ///
  /// Takes a [String] [productId] as a parameter and returns [void] wrapped in an [Either] indicating success or failure.
  Future<Either<Failure, void>> deleteProduct(String productId);
}