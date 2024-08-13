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

  const cachedProductsKey = 'CACHED_PRODUCTS';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getAllProducts', () {
    final tProductList = [
      const ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
      ),
      // Additional products...
    ];

    test('should return List<ProductModel> when there is cached data',
        () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json
          .encode(tProductList.map((product) => product.toJson()).toList()));
      // act
      final result = await dataSource.getAllProducts();
      // assert
      expect(result, equals(tProductList));
    });

    test('should throw CacheException when there is no cached data', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);
      // act
      final call = dataSource.getAllProducts;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('getProduct', () {
    const tProduct = ProductModel(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
    );

    test('should return ProductModel when product exists in cache', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(json.encode([tProduct.toJson()]));
      // act
      final result = await dataSource.getProduct(tProduct.id);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when product is not found in cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(json.encode([]));
      // act
      final call = dataSource.getProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<CacheException>()));
    });
  });

  group('insertProduct', () {
    const tProduct = ProductModel(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
    );

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(json.encode([]));
      when(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([tProduct.toJson()]),
      )).thenAnswer((_) async => true);
      // act
      await dataSource.insertProduct(tProduct);
      // assert
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([tProduct.toJson()]),
      ));
    });
  });

  group('updateProduct', () {
    const tProduct = ProductModel(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
    );

    test('should update the cached product data', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(json.encode([tProduct.toJson()]));
      when(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([tProduct.toJson()]),
      )).thenAnswer((_) async => true);
      // act
      await dataSource.updateProduct(tProduct);
      // assert
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([tProduct.toJson()]),
      ));
    });

    test('should throw CacheException if product to be updated is not found',
        () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);
      // act
      final call = dataSource.updateProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
    });
  });

  group('deleteProduct', () {
    const tProductId = '6672752cbd218790438efdb0';
    const tProductList = [
      ProductModel(
        id: tProductId,
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
      ),
    ];

    test('should delete the product from cache', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(json
          .encode(tProductList.map((product) => product.toJson()).toList()));
      when(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([]),
      )).thenAnswer((_) async => true);
      // act
      await dataSource.deleteProduct(tProductId);
      // assert
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode([]),
      ));
    });

    test('should throw CacheException if product to be deleted is not found',
        () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);
      // act
      final call = dataSource.deleteProduct;
      // assert
      expect(() => call(tProductId), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProducts', () {
    const tProductList = [
      ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
      ),
      // Additional products...
    ];

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(tProductList.map((product) => product.toJson()).toList()),
      )).thenAnswer((_) async => true);

      // act
      await dataSource.cacheProducts(tProductList);

      // assert
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        json.encode(tProductList.map((product) => product.toJson()).toList()),
      ));
    });
  });
}
