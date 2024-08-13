import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  const tProduct = ProductModel(
    id: '6672752cbd218790438efdb0',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  );

  final tProductJson = jsonEncode(tProduct.toJson());

  final tProductList = [
    tProduct,
    // Additional products...
  ];

  final tProductListJson = jsonEncode(
    {'data': tProductList.map<Map<String, dynamic>>((product) => product.toJson()).toList()},
  );

  group('getAllProducts', () {
    test('should return List<ProductModel> when data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('products'))
          .thenReturn(tProductListJson);
      // act
      final result = await dataSource.getAllProducts();
      // assert
      expect(result, equals(tProductList));
    });

    test('should throw CacheException when no data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('products'))
          .thenReturn(null);
      // act
      final call = dataSource.getAllProducts;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('getProduct', () {
    test('should return ProductModel when data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('product_${tProduct.id}'))
          .thenReturn(tProductJson);
      // act
      final result = await dataSource.getProduct(tProduct.id);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when no data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('product_${tProduct.id}'))
          .thenReturn(null);
      // act
      final call = dataSource.getProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<CacheException>()));
    });
  });

  group('insertProduct', () {
    test('should return ProductModel when product is inserted', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.insertProduct(tProduct);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when insertion fails', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => false);
      // act
      final call = dataSource.insertProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
    });
  });

  group('updateProduct', () {
    test('should return ProductModel when product is updated', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.updateProduct(tProduct);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when update fails', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => false);
      // act
      final call = dataSource.updateProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
    });
  });

  group('deleteProduct', () {
    test('should return String when product is deleted', () async {
      // arrange
      when(mockSharedPreferences.remove('product_${tProduct.id}'))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.deleteProduct(tProduct.id);
      // assert
      expect(result, equals('Product deleted successfully'));
    });

    test('should throw CacheException when deletion fails', () async {
      // arrange
      when(mockSharedPreferences.remove('product_${tProduct.id}'))
          .thenAnswer((_) async => false);
      // act
      final call = dataSource.deleteProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProducts', () {
    test('should return the first ProductModel when caching succeeds', () async {
      // arrange
      when(mockSharedPreferences.setString('products', tProductListJson))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.cacheProducts(tProductList);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when caching fails', () async {
      // arrange
      when(mockSharedPreferences.setString('products', tProductListJson))
          .thenAnswer((_) async => false);
      // act
      final call = dataSource.cacheProducts;
      // assert
      expect(() => call(tProductList), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProduct', () {
    test('should return ProductModel when caching succeeds', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.cacheProduct(tProduct);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when caching fails', () async {
      // arrange
      when(mockSharedPreferences.setString('product_${tProduct.id}', tProductJson))
          .thenAnswer((_) async => false);
      // act
      final call = dataSource.cacheProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
    });
  });

  group('getLastProducts', () {
    test('should return List<ProductModel> when data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('products'))
          .thenReturn(tProductListJson);
      // act
      final result = await dataSource.getLastProducts();
      // assert
      expect(result, equals(tProductList));
    });

    test('should throw CacheException when no data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('products'))
          .thenReturn(null);
      // act
      final call = dataSource.getLastProducts;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('getCachedProduct', () {
    test('should return ProductModel when data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('product_${tProduct.id}'))
          .thenReturn(tProductJson);
      // act
      final result = await dataSource.getCachedProduct(tProduct.id);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when no data is cached', () async {
      // arrange
      when(mockSharedPreferences.getString('product_${tProduct.id}'))
          .thenReturn(null);
      // act
      final call = dataSource.getCachedProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<CacheException>()));
    });
  });
}
