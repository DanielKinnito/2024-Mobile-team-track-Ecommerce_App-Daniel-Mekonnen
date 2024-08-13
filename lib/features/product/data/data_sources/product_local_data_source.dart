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
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> cacheProduct(ProductModel product);
  Future<List<ProductModel>> getLastProducts();
  Future<ProductModel> getCachedProduct(String id);
}

const cachedProductsKey = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      try {
        return products.firstWhere((product) => product.id == id);
      } catch (_) {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      products.add(product);
      await cacheProducts(products);
    } else {
      await cacheProducts([product]);
    }
  }

  @override
  Future<void> updateProduct(ProductModel updatedProduct) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      final index = products.indexWhere((product) => product.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
        await cacheProducts(products);
      } else {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      products.removeWhere((product) => product.id == id);
      await cacheProducts(products);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final List<Map<String, dynamic>> jsonList =
        products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cachedProductsKey, jsonString);
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      products.add(product);
      await cacheProducts(products);
    } else {
      await cacheProducts([product]);
    }
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    return await getAllProducts();
  }

  @override
  Future<ProductModel> getCachedProduct(String id) async {
    return await getProduct(id);
  }
}
