import 'package:dartz/dartz.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

/// Implementation of the [ProductRepository] interface.
///
/// This class handles data operations for products, utilizing both remote and local data sources.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  /// Constructs a new [ProductRepositoryImpl] instance.
  ///
  /// Requires [ProductRemoteDataSource], [ProductLocalDataSource], and [NetworkInfo].
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct.toEntity());
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch the product from the server.'));
      }
    } else {
      try {
        final localProduct = await localDataSource.getCachedProduct(id);
        return Right(localProduct.toEntity());
      } on CacheException {
        return const Left(CacheFailure('Failed to fetch the product from the cache.'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    try {
      await remoteDataSource.insertProduct(productModel);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure('Failed to insert the product on the server.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    try {
      await remoteDataSource.updateProduct(productModel);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure('Failed to update the product on the server.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure('Failed to delete the product on the server.'));
    }
  }
  
  @override
  Future<Either<Failure, List<Product>>> getAllProdcuts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Failed to fetch products from the server.'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts.map((model) => model.toEntity()).toList());
      } on CacheException {
        return const Left(CacheFailure('Failed to fetch products from the cache.'));
      }
    }
  }
  
}
