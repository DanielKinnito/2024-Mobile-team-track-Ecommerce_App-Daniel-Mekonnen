import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';

import '../../../../core/exception/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String id);
  Future<bool> insertProduct(ProductModel product);
  Future<bool> updateProduct(ProductModel product);
  Future<bool> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(Urls.getAllProducts()));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['data']; // Ensure this is a list
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.getProduct(id)));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> insertProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(Urls.insertProduct()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse(Urls.updateProduct(product.id)),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.deleteProduct(id)));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
