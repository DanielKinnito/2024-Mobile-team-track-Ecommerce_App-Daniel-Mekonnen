import 'package:dartz/dartz.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      final result = await productRemoteDataSource.deleteProduct(productId);
      return result.fold(
        (failure) => Left(failure), // Forward the failure
        (success) => const Right(null), // No content returned
      );
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productId) async {
    try {
      final result = await productRemoteDataSource.getProduct(productId);
      return result.fold(
        (failure) => Left(failure),
        (productModel) => Right(ProductModel.fromDomain(productModel)), // Convert to Product
      );
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    try {
      final productModel = ProductModel.fromDomain(product);
      final result = await productRemoteDataSource.insertProduct(productModel);
      return result.fold(
        (failure) => Left(failure),
        (success) => const Right(null),
      );
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final productModel = ProductModel.fromDomain(product);
      final result = await productRemoteDataSource.updateProduct(productModel);
      return result.fold(
        (failure) => Left(failure),
        (success) => const Right(null),
      );
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await productRemoteDataSource.getAllProducts();
      return result.fold(
        (failure) => Left(failure),
        (productModelList) => Right(
          productModelList.map((productModel) => ProductModel.fromDomain(productModel)).toList(),
        ), // Convert list of ProductModel to List<Product>
      );
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
