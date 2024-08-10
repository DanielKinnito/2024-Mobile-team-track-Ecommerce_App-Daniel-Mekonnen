import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, void>> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<Product>>> getAllProdcuts() {
    // TODO: implement getAllProdcuts
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Product>> getProduct(String productId) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> insertProduct(Product product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  
}
