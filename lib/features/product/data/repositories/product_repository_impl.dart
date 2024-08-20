import 'package:dartz/dartz.dart';

import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSourceImpl remoteDataSource;
  final ProductLocalDataSourceImpl localDataSource;
  final NetworkInfoImpl networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure('$e.message'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getAllProducts();
        return Right(localProducts);
      } on CacheException catch (e) {
        return Left(CacheFailure('$e.message'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } on ServerException catch (e) {
        return Left(ServerFailure('$e.message'));
      }
    } else {
      try {
        final localProduct = await localDataSource.getCachedProduct(id);
        return Right(localProduct);
      } on CacheException catch (e) {
        return Left(CacheFailure('$e.message'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        // Convert Product to ProductModel
        final productModel = ProductModel.fromEntity(product);
        final insertedProductModel =
            await remoteDataSource.insertProduct(productModel);
        localDataSource.cacheProduct(insertedProductModel);
        // Convert ProductModel to Product
        final insertedProduct = insertedProductModel.toEntity();
        return Right(insertedProduct);
      } on ServerException {
        return const Left(ServerFailure('server Failure'));
      }
    } else {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        // Convert Product to ProductModel
        final productModel = ProductModel.fromEntity(product);
        final updatedProductModel =
            await remoteDataSource.updateProduct(productModel);
        localDataSource.cacheProduct(updatedProductModel);
        // Convert ProductModel to Product
        final updatedProduct = updatedProductModel.toEntity();
        return Right(updatedProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final message = await remoteDataSource.deleteProduct(id);
        localDataSource.deleteProduct(id);
        return Right(message);
      } on ServerException catch (e) {
        return Left(ServerFailure('$e.message'));
      }
    } else {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }
}
