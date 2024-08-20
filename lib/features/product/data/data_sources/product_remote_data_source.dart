import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/exception/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String id);
  Future<ProductModel> insertProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<String> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  ProductRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  Future<String?> _getToken() async {
    return sharedPreferences.getString('access_token');
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final response = await client.get(
      Uri.parse(Urls.getAllProducts()),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['data'];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final response = await client.get(
      Uri.parse(Urls.getProduct(id)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final response = await client.post(
      Uri.parse(Urls.insertProduct()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final response = await client.put(
      Uri.parse(Urls.updateProduct(product.id)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final response = await client.delete(
      Uri.parse(Urls.deleteProduct(id)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
