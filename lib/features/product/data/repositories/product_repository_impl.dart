import 'package:dartz/dartz.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  late ProductRemoteDataSourceImpl productRemoteDataSource;
  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      final result = await productRemoteDataSource.deleteProduct(productId);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProduct(String productId) async {
    try {
      final result = await productRemoteDataSource.getProduct(productId);
      return Right(result as ProductModel);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    try {
      final result = await productRemoteDataSource.insertProduct(product);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await productRemoteDataSource.getAllProducts();
      return Right(result as List<Product>);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<Either<Failure, List<Product>>> getAllProdcuts() {
    // TODO: implement getAllProdcuts
    throw UnimplementedError();
  }
}