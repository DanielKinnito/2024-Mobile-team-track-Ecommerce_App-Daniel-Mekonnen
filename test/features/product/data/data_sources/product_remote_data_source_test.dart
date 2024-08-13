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

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tProduct = ProductModel(
    id: '6672752cbd218790438efdb0',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  );

  final tProductJson = jsonEncode({'data': tProduct.toJson()});

  final tProductList = [
    tProduct,
    // Additional products...
  ];

  final tProductListJson = jsonEncode(
    {'data': tProductList.map<Map<String, dynamic>>((product) => product.toJson()).toList()},
  );

  group('getAllProducts', () {
    test('should return List<ProductModel> when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getAllProducts())))
          .thenAnswer((_) async => http.Response(tProductListJson, 200));
      // act
      final result = await dataSource.getAllProducts();
      // assert
      expect(result, equals(tProductList));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getAllProducts())))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));
      // act
      final call = dataSource.getAllProducts;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getProduct', () {
    test('should return ProductModel when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(tProduct.id))))
          .thenAnswer((_) async => http.Response(tProductJson, 200));
      // act
      final result = await dataSource.getProduct(tProduct.id);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(tProduct.id))))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));
      // act
      final call = dataSource.getProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<ServerException>()));
    });
  });

  group('insertProduct', () {
    test('should return ProductModel when the response code is 201', () async {
      // arrange
      when(mockHttpClient.post(
        Uri.parse(Urls.insertProduct()),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tProduct.toJson()),
      )).thenAnswer((_) async => http.Response(tProductJson, 201));
      // act
      final result = await dataSource.insertProduct(tProduct);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw ServerException when the response code is not 201', () async {
      // arrange
      when(mockHttpClient.post(
        Uri.parse(Urls.insertProduct()),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tProduct.toJson()),
      )).thenAnswer((_) async => http.Response('Something went wrong', 500));
      // act
      final call = dataSource.insertProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    test('should return ProductModel when the response code is 200', () async {
      // arrange
      when(mockHttpClient.put(
        Uri.parse(Urls.updateProduct(tProduct.id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tProduct.toJson()),
      )).thenAnswer((_) async => http.Response(tProductJson, 200));
      // act
      final result = await dataSource.updateProduct(tProduct);
      // assert
      expect(result, equals(tProduct));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.put(
        Uri.parse(Urls.updateProduct(tProduct.id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tProduct.toJson()),
      )).thenAnswer((_) async => http.Response('Something went wrong', 500));
      // act
      final call = dataSource.updateProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    test('should return String when the response code is 200', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct(tProduct.id))))
          .thenAnswer((_) async => http.Response('Product deleted successfully', 200));
      // act
      final result = await dataSource.deleteProduct(tProduct.id);
      // assert
      expect(result, equals('Product deleted successfully'));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct(tProduct.id))))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));
      // act
      final call = dataSource.deleteProduct;
      // assert
      expect(() => call(tProduct.id), throwsA(isA<ServerException>()));
    });
  });
}
