import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/exception/exception.dart';
import '../models/product_model.dart';

/// A data source for handling local operations related to products.
///
/// This class uses `SharedPreferences` to store and retrieve products locally.
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String id);
  Future<ProductModel> insertProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<String> deleteProduct(String id);
  Future<ProductModel> cacheProducts(List<ProductModel> products);
  Future<ProductModel> cacheProduct(ProductModel product);
  Future<List<ProductModel>> getLastProducts();
  Future<ProductModel> getCachedProduct(String id);
}

/// A data source for handling local operations related to products.
///
/// This class uses `SharedPreferences` to store and retrieve products locally.
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final jsonString = sharedPreferences.getString('products');
    if (jsonString != null) {
      final List<dynamic> productsJson =
          json.decode(jsonString)['data'] as List<dynamic>;
      return productsJson.map((dynamic json) {
        if (json is Map<String, dynamic>) {
          return ProductModel.fromJson(json);
        } else {
          throw CacheException(); // Handle unexpected data types
        }
      }).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final jsonString = sharedPreferences.getString('product_$id');
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        return ProductModel.fromJson(jsonMap);
      } catch (e) {
        throw CacheException(); // Handle JSON parsing errors
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    final jsonString = json.encode(product.toJson());
    final result =
        await sharedPreferences.setString('product_${product.id}', jsonString);
    if (result) {
      return product;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final jsonString = json.encode(product.toJson());
    final result =
        await sharedPreferences.setString('product_${product.id}', jsonString);
    if (result) {
      return product;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final result = await sharedPreferences.remove('product_$id');
    if (result) {
      return 'Product deleted successfully';
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> cacheProducts(List<ProductModel> products) async {
    final jsonList = products.map((product) => product.toJson()).toList();
    final jsonString = json.encode({'data': jsonList});
    final result = await sharedPreferences.setString('products', jsonString);
    if (result) {
      // Return the first product if the list is not empty
      if (products.isNotEmpty) {
        return products.first;
      } else {
        throw CacheException(); // Handle empty product list
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> cacheProduct(ProductModel product) async {
    final jsonString = json.encode(product.toJson());
    final result =
        await sharedPreferences.setString('product_${product.id}', jsonString);
    if (result) {
      return product;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    // Assuming this is similar to getAllProducts
    final jsonString = sharedPreferences.getString('products');
    if (jsonString != null) {
      final List<dynamic> productsJson =
          json.decode(jsonString)['data'] as List<dynamic>;
      return productsJson.map((dynamic json) {
        if (json is Map<String, dynamic>) {
          return ProductModel.fromJson(json);
        } else {
          throw CacheException(); // Handle unexpected data types
        }
      }).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getCachedProduct(String id) async {
    final jsonString = sharedPreferences.getString('product_$id');
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        return ProductModel.fromJson(jsonMap);
      } catch (e) {
        throw CacheException(); // Handle JSON parsing errors
      }
    } else {
      throw CacheException();
    }
  }
}
