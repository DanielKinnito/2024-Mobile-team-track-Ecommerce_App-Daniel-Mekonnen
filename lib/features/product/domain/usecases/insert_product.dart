import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Represents a use case for inserting a product.
///
/// This use case is responsible for inserting a product into the repository.
/// It takes a [Product] as a parameter and returns a [Future] that resolves
/// to an [Either] containing a [Failure] or a [Product].
class InsertProduct extends Usecase<Future<Either<Failure, Product>>, Product> {
  final ProductRepository repository;

  InsertProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product params) async {
    return await repository.insertProduct(params);
  }
}
