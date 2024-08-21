import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:myapp/core/constants/constants.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductRemoteDataSourceImpl(
      client: mockHttpClient,
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('ProductRemoteDataSourceImpl', () {
    const tToken = 'test_token';
    const tProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Description of Test Product',
      price: 10.0,
      imageUrl: 'http://example.com/image.png',
    );

    final tProductList = [tProduct];
    final tProductListJson =
        json.encode({'data': tProductList.map((p) => p.toJson()).toList()});

    setUp(() {
      when(mockSharedPreferences.getString('access_token')).thenReturn(tToken);
    });

    test('should return list of products when getAllProducts is called',
        () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.getAllProducts()),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async => http.Response(tProductListJson, 200));

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      expect(result, tProductList);
      verify(mockHttpClient.get(
        Uri.parse(Urls.getAllProducts()),
        headers: {'Authorization': 'Bearer $tToken'},
      )).called(1);
    });

    test(
        'should throw AuthenticationException when token is null in getAllProducts',
        () async {
      // Arrange
      when(mockSharedPreferences.getString('access_token')).thenReturn(null);

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<AuthenticationException>()));
    });

    test(
        'should throw ServerException when getAllProducts returns non-200 status code',
        () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.getAllProducts()),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test('should return a product when getProduct is called', () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.getProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async =>
          http.Response(json.encode({'data': tProduct.toJson()}), 200));

      // Act
      final result = await dataSource.getProduct('1');

      // Assert
      expect(result, tProduct);
      verify(mockHttpClient.get(
        Uri.parse(Urls.getProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).called(1);
    });

    test(
        'should throw AuthenticationException when token is null in getProduct',
        () async {
      // Arrange
      when(mockSharedPreferences.getString('access_token')).thenReturn(null);

      // Act
      final call = dataSource.getProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<AuthenticationException>()));
    });

    test(
        'should throw ServerException when getProduct returns non-200 status code',
        () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse(Urls.getProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = dataSource.getProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<ServerException>()));
    });

    test(
        'should throw AuthenticationException when token is null in insertProduct',
        () async {
      // Arrange
      when(mockSharedPreferences.getString('access_token')).thenReturn(null);

      // Act
      final call = dataSource.insertProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<AuthenticationException>()));
    });

    test('should return a product when updateProduct is called', () async {
      // Arrange
      when(mockHttpClient.put(
        Uri.parse(Urls.updateProduct(tProduct.id)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tToken',
        },
        body: json.encode(tProduct.toJson()),
      )).thenAnswer((_) async =>
          http.Response(json.encode({'data': tProduct.toJson()}), 200));

      // Act
      final result = await dataSource.updateProduct(tProduct);

      // Assert
      expect(result, tProduct);
      verify(mockHttpClient.put(
        Uri.parse(Urls.updateProduct(tProduct.id)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tToken',
        },
        body: json.encode(tProduct.toJson()),
      )).called(1);
    });

    test(
        'should throw AuthenticationException when token is null in updateProduct',
        () async {
      // Arrange
      when(mockSharedPreferences.getString('access_token')).thenReturn(null);

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<AuthenticationException>()));
    });

    test(
        'should throw ServerException when updateProduct returns non-200 status code',
        () async {
      // Arrange
      when(mockHttpClient.put(
        Uri.parse(Urls.updateProduct(tProduct.id)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tToken',
        },
        body: json.encode(tProduct.toJson()),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });

    test('should return success message when deleteProduct is called',
        () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse(Urls.deleteProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async => http.Response('Deleted', 200));

      // Act
      final result = await dataSource.deleteProduct('1');

      // Assert
      expect(result, 'Deleted');
      verify(mockHttpClient.delete(
        Uri.parse(Urls.deleteProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).called(1);
    });

    test(
        'should throw AuthenticationException when token is null in deleteProduct',
        () async {
      // Arrange
      when(mockSharedPreferences.getString('access_token')).thenReturn(null);

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<AuthenticationException>()));
    });

    test(
        'should throw ServerException when deleteProduct returns non-200 status code',
        () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse(Urls.deleteProduct('1')),
        headers: {'Authorization': 'Bearer $tToken'},
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<ServerException>()));
    });
  });
}
