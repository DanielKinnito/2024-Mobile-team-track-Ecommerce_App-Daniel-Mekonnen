import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

/// Represents a use case for deleting a product.
///
/// This use case is responsible for deleting a product from the repository.
/// It takes a [String] parameter representing the product ID and returns a [Future] that
/// resolves to an [Either] containing a [Failure] or a [String] message.
///
/// Example usage:
/// ```dart
/// final deleteProduct = DeleteProduct(productRepository);
/// final result = await deleteProduct('product_id');
/// result.fold(
///   (failure) => print('Failed to delete product: $failure'),
///   (message) => print('Product deletion message: $message'),
/// );
/// ```
class DeleteProduct extends Usecase<Future<Either<Failure, String>>, String> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.deleteProduct(params);
  }
}
