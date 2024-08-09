import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<Either<Failure, ProductModel>> getProduct(String productId);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, void>> cacheProduct(Product product);
  Future<Either<Failure, void>> cacheAllProducts(List<Product> products);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, ProductModel>> getProduct(String productId) async {
    try {
      final jsonString = sharedPreferences.getString(productId);
      if (jsonString != null) {
        final productModel = ProductModel.forLocalJson(json.decode(jsonString));
        return Right(productModel);
      } else {
        return const Left(
            CacheFailure('Product not found in cache')); // Handle cache failure
      }
    } catch (e) {
      return const Left(CacheFailure(
          'Error getting product from cache')); // Handle cache failure
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      final jsonString = sharedPreferences.getString(productId);
      if (jsonString != null) {
        await sharedPreferences.remove(productId);
        return const Right(null); // Success case
      } else {
        return const Left(
            CacheFailure('Product not found in cache')); // Handle cache failure
      }
    } catch (e) {
      return const Left(CacheFailure(
          'Error deleting product from cache')); // Handle cache failure
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    try {
      final jsonString = jsonEncode(ProductModel.fromDomain(product).toJson());
      await sharedPreferences.setString(product.id.toString(), jsonString);
      return const Right(null); // Success case
    } catch (e) {
      return const Left(CacheFailure(
          'Error inserting product into cache')); // Handle cache failure
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final jsonString = jsonEncode(ProductModel.fromDomain(product).toJson());
      await sharedPreferences.setString(product.id.toString(), jsonString);
      return const Right(null); // Success case
    } catch (e) {
      return const Left(CacheFailure(
          'Error updating product in cache')); // Handle cache failure
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final List<String>? jsonStringList =
          sharedPreferences.getStringList('productList');
      if (jsonStringList != null && jsonStringList.isNotEmpty) {
        final List<Product> products = jsonStringList
            .map((jsonString) =>
                ProductModel.forLocalJson(jsonDecode(jsonString)))
            .toList();
        return Right(products);
      } else {
        return const Left(CacheFailure('No products found in cache'));
      }
    } catch (e) {
      return const Left(CacheFailure('Error getting products from cache'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheAllProducts(List<Product> products) async {
    try {
      final jsonString = jsonEncode(
          products.map((e) => ProductModel.fromDomain(e).toJson()).toList());
      final result =
          await sharedPreferences.setStringList('productList', [jsonString]);

      if (result) {
        return const Right(null);
      } else {
        return const Left(CacheFailure('Error caching products in cache'));
      }
    } catch (e) {
      return const Left(CacheFailure('Error caching products in cache'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheProduct(Product product) async {
    try {
      final jsonString = jsonEncode(ProductModel.fromDomain(product).toJson());
      await sharedPreferences.setString(product.id.toString(), jsonString);
      return const Right(null); // Success case
    } catch (e) {
      return const Left(CacheFailure(
          'Error caching product in cache')); // Handle cache failure
    }
  }
}
