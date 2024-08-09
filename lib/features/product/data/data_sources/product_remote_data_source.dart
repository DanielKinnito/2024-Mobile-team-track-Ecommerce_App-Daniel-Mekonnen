import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource{
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
    final response = await client.get(Uri.parse(Urls.getProduct(productId)));

    if (response.statusCode == 200) {
      return Right(ProductModel.fromJson(json.decode(response.body)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    List<Product> allProducts = [];
    final response = await client.get(Uri.parse(Urls.baseUrl));

    if (response.statusCode == 200) {
      // return ProductModel.fromJson(json.decode(response.body));

      final data = jsonDecode(response.body);
      data['data']
          .forEach((el) async => {allProducts.add(ProductModel.fromJson(el))});
      return Right(allProducts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    final response = await client.delete(Uri.parse(Urls.getProduct(productId)));

    if (response.statusCode == 200) {
    } else {
      throw ServerException();
    }
    throw ServerException();
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    final Map<String, String> mapper = {
      'id': product.id,
      'image': product.imageUrl,
      'name': product.name,
      'description': product.description,
      'price': '${product.price}'
    };
    final response =
        await client.post(Uri.parse(Urls.baseUrl), headers: mapper);

    if (response.statusCode == 201) {
    } else {
      throw ServerException();
    }

    throw ServerException();
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    final Map<String, String> mapper = {
      'id': '1',
      'image': 'https://picsum.photos/200/300',
      'name': 'Shoe',
      'description': 'something',
      'price': '123.4'
    };
    final response =
        await client.put(Uri.parse(Urls.getProduct(product.id)), headers: mapper);

    if (response.statusCode == 200) {
    } else {
      throw ServerException();
    }
    throw ServerException();
  }
}