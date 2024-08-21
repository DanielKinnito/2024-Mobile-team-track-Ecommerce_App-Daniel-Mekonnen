import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';

import '../../helpers/mocks.mocks.dart';

// Mock SharedPreferences

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('ProductLocalDataSourceImpl', () {
    const tProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Description of Test Product',
      price: 10.0,
      imageUrl: 'http://example.com/image.png',
    );

    final tProductList = [tProduct];

    final tProductJson = json.encode(tProduct.toJson());
    final tProductListJson = json.encode({'data': tProductList.map((p) => p.toJson()).toList()});

    test('should return a list of products when getAllProducts is called', () async {
      // Arrange
      when(mockSharedPreferences.getString('products')).thenReturn(tProductListJson);

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      expect(result, tProductList);
      verify(mockSharedPreferences.getString('products')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when getAllProducts returns null', () async {
      // Arrange
      when(mockSharedPreferences.getString('products')).thenReturn(null);

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString('products')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return a product when getProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.getString('product_1')).thenReturn(tProductJson);

      // Act
      final result = await dataSource.getProduct('1');

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.getString('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when getProduct returns null', () async {
      // Arrange
      when(mockSharedPreferences.getString('product_1')).thenReturn(null);

      // Act
      final call = dataSource.getProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return the product when insertProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.insertProduct(tProduct);

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when insertProduct fails', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.insertProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return the product when updateProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.updateProduct(tProduct);

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when updateProduct fails', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return success message when deleteProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.remove('product_1')).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.deleteProduct('1');

      // Assert
      expect(result, 'Product deleted successfully');
      verify(mockSharedPreferences.remove('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when deleteProduct fails', () async {
      // Arrange
      when(mockSharedPreferences.remove('product_1')).thenAnswer((_) async => false);

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.remove('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return the first product when cacheProducts is called with non-empty list', () async {
      // Arrange
      when(mockSharedPreferences.setString('products', tProductListJson)).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.cacheProducts(tProductList);

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.setString('products', tProductListJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when cacheProducts fails', () async {
      // Arrange
      when(mockSharedPreferences.setString('products', tProductListJson)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.cacheProducts;

      // Assert
      expect(() => call(tProductList), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.setString('products', tProductListJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return the product when cacheProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.cacheProduct(tProduct);

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when cacheProduct fails', () async {
      // Arrange
      when(mockSharedPreferences.setString('product_1', tProductJson)).thenAnswer((_) async => false);

      // Act
      final call = dataSource.cacheProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.setString('product_1', tProductJson)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return a list of products when getLastProducts is called', () async {
      // Arrange
      when(mockSharedPreferences.getString('products')).thenReturn(tProductListJson);

      // Act
      final result = await dataSource.getLastProducts();

      // Assert
      expect(result, tProductList);
      verify(mockSharedPreferences.getString('products')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when getLastProducts returns null', () async {
      // Arrange
      when(mockSharedPreferences.getString('products')).thenReturn(null);

      // Act
      final call = dataSource.getLastProducts;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString('products')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return a product when getCachedProduct is called', () async {
      // Arrange
      when(mockSharedPreferences.getString('product_1')).thenReturn(tProductJson);

      // Act
      final result = await dataSource.getCachedProduct('1');

      // Assert
      expect(result, tProduct);
      verify(mockSharedPreferences.getString('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when getCachedProduct returns null', () async {
      // Arrange
      when(mockSharedPreferences.getString('product_1')).thenReturn(null);

      // Act
      final call = dataSource.getCachedProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString('product_1')).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
