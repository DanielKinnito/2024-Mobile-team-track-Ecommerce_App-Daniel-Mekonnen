import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProduct extends Usecase<Future<Either<Failure, void>>, String> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteProduct(params);
  }
}