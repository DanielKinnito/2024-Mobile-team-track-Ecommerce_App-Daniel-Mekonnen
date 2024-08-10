import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for retrieving a product.
///
/// This use case is responsible for retrieving a product from the repository.
/// It takes a [String] parameter representing the product ID and returns a [Future] that
/// resolves to an [Either] containing a [Failure] or a [Product].
///
/// Example usage:
/// ```dart
/// final getProduct = GetProduct(productRepository);
/// final result = await getProduct('product_id');
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (product) => print('Product: $product'),
/// );
/// ```
class GetProduct extends Usecase<Future<Either<Failure, Product>>, String> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(String params) async {
    return await repository.getProduct(params);
  }
}
