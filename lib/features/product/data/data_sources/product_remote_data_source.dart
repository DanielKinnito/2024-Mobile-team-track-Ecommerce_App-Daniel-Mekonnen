import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, ProductModel>> getProduct(String productId);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String productId);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, ProductModel>> getProduct(String productId) async {
    try {
      final response = await client.get(Uri.parse(Urls.getProduct(productId)));

      if (response.statusCode == 200) {
        return Right(ProductModel.fromJson(json.decode(response.body)));
      } else {
        return const Left(ServerFailure('Failed to fetch product'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch product: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final response = await client.get(Uri.parse(Urls.baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> allProducts = (data['data'] as List)
            .map((el) => ProductModel.fromJson(el))
            .toList();
        return Right(allProducts);
      } else {
        return const Left(ServerFailure('Failed to fetch all products'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch all products: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      final response = await client.delete(Uri.parse(Urls.getProduct(productId)));

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure('Failed to delete product'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to delete product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    try {
      final response = await client.post(
        Uri.parse(Urls.baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': product.id,
          'image': product.imageUrl,
          'name': product.name,
          'description': product.description,
          'price': '${product.price}'
        }),
      );

      if (response.statusCode == 201) {
        return const Right(null);
      } else {
        return const Left(ServerFailure('Failed to insert product'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to insert product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final response = await client.put(
        Uri.parse(Urls.getProduct(product.id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': product.id,
          'image': product.imageUrl,
          'name': product.name,
          'description': product.description,
          'price': '${product.price}'
        }),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure('Failed to update product'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to update product: $e'));
    }
  }
}
