import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/no_param_usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// A use case that retrieves all products.
///
/// This use case is responsible for fetching all products from the repository.
/// It extends the [NoParamUsecase] class and returns a [Future] that resolves
/// to an [Either] object containing a [Failure] or a list of [Product] objects.
///
/// Example usage:
/// ```dart
/// final getAllProducts = GetAllProducts(productRepository);
/// final result = await getAllProducts();
/// result.fold(
///   (failure) => print('Failed to retrieve products: $failure'),
///   (products) => print('Retrieved ${products.length} products'),
/// );
/// ```
class GetAllProducts
    extends NoParamUsecase<Future<Either<Failure, List<Product>>>> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProdcuts();
  }
}
