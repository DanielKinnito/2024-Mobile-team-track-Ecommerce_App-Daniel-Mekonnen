import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Represents a use case for updating a product.
///
/// This use case is responsible for updating a product in the system.
/// It takes a [Product] object as a parameter and returns a [Future] that
/// resolves to an [Either] containing a [Failure] or `void`.
///
/// Example usage:
/// ```dart
/// final updateProduct = UpdateProduct(productRepository);
/// final result = await updateProduct(product);
/// result.fold(
///   (failure) => print('Failed to update product: $failure'),
///   (_) => print('Product updated successfully'),
/// );
/// ```
class UpdateProduct extends Usecase<Future<Either<Failure, void>>, Product> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(Product params) async {
    return await repository.updateProduct(params);
  }
}
