import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('ProductLocalDataSourceImpl - Tests', () {
    const productModel = ProductModel(
      id: '66b0b23928f63adda72ab38a',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
    );

    final productModelList = [productModel];

    group('getProduct', () {
      test('should return a product from SharedPreferences', () async {
        // Arrange
        final expectedJsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.getString(productModel.id))
            .thenReturn(expectedJsonString);

        // Act
        final result = await dataSourceImpl.getProduct(productModel.id);

        // Assert
        expect(result, const Right(productModel));
        verify(mockSharedPreferences.getString(productModel.id));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test('should return CacheFailure when product is not found', () async {
        // Arrange
        when(mockSharedPreferences.getString(productModel.id)).thenReturn(null);

        // Act
        final result = await dataSourceImpl.getProduct(productModel.id);

        // Assert
        expect(result, const Left(CacheFailure('Product not found in cache')));
        verify(mockSharedPreferences.getString(productModel.id));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('deleteProduct', () {
      test('should delete a product from SharedPreferences', () async {
        // Arrange
        when(mockSharedPreferences.getString(productModel.id))
            .thenReturn(jsonEncode(productModel.toJson()));

        // Act
        final result = await dataSourceImpl.deleteProduct(productModel.id);

        // Assert
        expect(result, const Right(null));
        verify(mockSharedPreferences.remove(productModel.id));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test('should return CacheFailure when product to delete is not found',
          () async {
        // Arrange
        when(mockSharedPreferences.getString(productModel.id)).thenReturn(null);

        // Act
        final result = await dataSourceImpl.deleteProduct(productModel.id);

        // Assert
        expect(result, const Left(CacheFailure('Product not found in cache')));
        verify(mockSharedPreferences.getString(productModel.id));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('insertProduct', () {
      test('should insert a product into SharedPreferences', () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(productModel.id, jsonString))
            .thenAnswer((_) async => true);

        // Act
        final result = await dataSourceImpl.insertProduct(productModel);

        // Assert
        expect(result, const Right(null));
        verify(mockSharedPreferences.setString(productModel.id, jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test(
          'should return CacheFailure when there is an error inserting product',
          () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(productModel.id, jsonString))
            .thenThrow(Exception());

        // Act
        final result = await dataSourceImpl.insertProduct(productModel);

        // Assert
        expect(result,
            const Left(CacheFailure('Error inserting product into cache')));
        verify(mockSharedPreferences.setString(productModel.id, jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('updateProduct', () {
      test('should update a product in SharedPreferences', () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(productModel.id, jsonString))
            .thenAnswer((_) async => true);

        // Act
        final result = await dataSourceImpl.updateProduct(productModel);

        // Assert
        expect(result, const Right(null));
        verify(mockSharedPreferences.setString(productModel.id, jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test('should return CacheFailure when there is an error updating product',
          () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(productModel.id, jsonString))
            .thenThrow(Exception());

        // Act
        final result = await dataSourceImpl.updateProduct(productModel);

        // Assert
        expect(result,
            const Left(CacheFailure('Error updating product in cache')));
        verify(mockSharedPreferences.setString(productModel.id, jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('getAllProducts', () {
      test('should return a list of products from SharedPreferences', () async {
        // Arrange
        final expectedJsonStringList =
            productModelList.map((e) => jsonEncode(e.toJson())).toList();
        when(mockSharedPreferences.getStringList('productList'))
            .thenReturn(expectedJsonStringList);

        // Act
        final result = await dataSourceImpl.getAllProducts();

        // Assert
        expect(result, isA<Right<Failure, List<ProductModel>>>());
        final productList = result.getOrElse(() => []);
        expect(productList, equals(productModelList));

        verify(mockSharedPreferences.getStringList('productList'));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test('should return CacheFailure when no products are found', () async {
        // Arrange
        when(mockSharedPreferences.getStringList('productList'))
            .thenReturn(null);

        // Act
        final result = await dataSourceImpl.getAllProducts();

        // Assert
        expect(result, const Left(CacheFailure('No products found in cache')));
        verify(mockSharedPreferences.getStringList('productList'));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('cacheProduct', () {
      test('should cache a product in SharedPreferences', () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(
                productModel.id.toString(), jsonString))
            .thenAnswer((_) async => true);

        // Act
        final result = await dataSourceImpl.cacheProduct(productModel);

        // Assert
        expect(result, const Right(null));
        verify(mockSharedPreferences.setString(
            productModel.id.toString(), jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test('should return CacheFailure when there is an error caching product',
          () async {
        // Arrange
        final jsonString = jsonEncode(productModel.toJson());
        when(mockSharedPreferences.setString(
                productModel.id.toString(), jsonString))
            .thenThrow(Exception());

        // Act
        final result = await dataSourceImpl.cacheProduct(productModel);

        // Assert
        expect(
            result, const Left(CacheFailure('Error caching product in cache')));
        verify(mockSharedPreferences.setString(
            productModel.id.toString(), jsonString));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });

    group('cacheAllProducts', () {
      test('should cache all products in SharedPreferences', () async {
        // Arrange
        final jsonStringList =
            productModelList.map((e) => jsonEncode(e.toJson())).toList();
        when(mockSharedPreferences.setStringList('productList', jsonStringList))
            .thenAnswer((_) async => true);

        // Act
        final result = await dataSourceImpl.cacheAllProducts(productModelList);

        // Assert
        expect(result, const Right(null));
        verify(
            mockSharedPreferences.setStringList('productList', jsonStringList));
        verifyNoMoreInteractions(mockSharedPreferences);
      });

      test(
          'should return CacheFailure when there is an error caching all products',
          () async {
        // Arrange
        final jsonStringList =
            productModelList.map((e) => jsonEncode(e.toJson())).toList();
        when(mockSharedPreferences.setStringList('productList', jsonStringList))
            .thenThrow(Exception());

        // Act
        final result = await dataSourceImpl.cacheAllProducts(productModelList);

        // Assert
        expect(result,
            const Left(CacheFailure('Error caching products in cache')));
        verify(
            mockSharedPreferences.setStringList('productList', jsonStringList));
        verifyNoMoreInteractions(mockSharedPreferences);
      });
    });
  });
}
