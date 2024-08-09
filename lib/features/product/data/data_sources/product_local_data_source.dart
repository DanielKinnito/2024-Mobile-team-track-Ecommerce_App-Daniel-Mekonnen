import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource{
  Future<Either<Failure, ProductModel>> getProduct(String productId);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String productId);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, ProductModel>> getProduct(String productId) async {
    final jsonString = sharedPreferences.getString(productId);
    if (jsonString != null) {
      try {
        return Right(ProductModel.forLocalJson(json.decode(jsonString)));
      } catch (e) {
        return Left(CacheException() as Failure);
    }
    } else {
      return Left(CacheException() as Failure);
  }
  }


  @override
  Future<Either<Failure, void>> deleteProduct(String productId) {
    // TODO: implement deleteProduct
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
  
  @override
  Future<Either<Failure, List<Product>>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

}