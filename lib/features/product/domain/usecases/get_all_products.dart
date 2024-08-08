import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/no_param_usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts
    extends NoParamUsecase<Future<Either<Failure, List<Product>>>> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async{
    return await repository.getAllProdcuts();
  }

}