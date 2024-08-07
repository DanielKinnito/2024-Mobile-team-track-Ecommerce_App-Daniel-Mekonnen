import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class InsertProduct extends Usecase<Future<Either<Failure, void>>, Product> {
  final ProductRepository repository;

  InsertProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(Product product) async {
    return await repository.insertProduct(product);
  }
}