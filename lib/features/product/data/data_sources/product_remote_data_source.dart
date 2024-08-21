import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      final List<ProductModel> products = jsonData
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      return products;
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      final product = ProductModel.fromJson(data);
      return product;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    final token = await _getToken();
    if (token == null) throw AuthenticationException();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.insertProduct()),
    );

    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    // Add fields
    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();

    // Add file
    if (product.imageUrl.isNotEmpty) {
      // Ensure the path is correct and the file exists
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Ensure this matches the server's expected field name
          product.imageUrl,
          contentType: MediaType('image', 'jpeg'), // Adjust MIME type as needed
        ),
      );
    }

    // Send request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(responseBody);
      return ProductModel.fromJson(data['data']);
    } else {
      // Print detailed error message
      print('Failed to insert product. Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');
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

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
