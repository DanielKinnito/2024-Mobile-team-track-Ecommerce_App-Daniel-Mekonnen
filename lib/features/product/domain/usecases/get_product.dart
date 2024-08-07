// Suggested code may be subject to a license. Learn more: ~LicenseLog:2360948635.
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProduct extends Usecase<Future<Either<Failure, Product>> , String> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(String productId) async{
    return await repository.getProduct(productId);
  }
}