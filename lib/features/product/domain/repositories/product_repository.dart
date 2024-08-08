import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProdcuts();
  Future<Either<Failure,Product>> getProduct(String productId);
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String productId);
}