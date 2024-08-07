import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct extends Usecase<Future<Either<Failure,void>>, Product> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(Product params) async {
    return await repository.updateProduct(params);
  }
}