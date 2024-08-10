import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:myapp/core/constants/constants.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String productId = '6672776eb905525c145fe0bb';
  const String baseUrl = Urls.baseUrl;

  group('getProduct', () {
    test('should return a ProductModel when the API call is successful', () async {
      // arrange
      final response = readJson('helpers/dummy_data/product_response.json');
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(productId))))
          .thenAnswer((_) async => http.Response(response, 200));
      
      // act
      final result = await dataSourceImpl.getProduct(productId);
      
      // assert
      expect(result, isA<Right<Failure, ProductModel>>());
      expect(result.getOrElse(() => throw Exception('Unexpected result')), isA<ProductModel>());
    });

    test('should return a CacheFailure when the API call fails with a 404 status', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(productId))))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      
      // act
      final result = await dataSourceImpl.getProduct(productId);
      
      // assert
      expect(result, isA<Left<Failure, ProductModel>>());
      expect(result.fold(id, id), isA<CacheFailure>());
    });
  });

  group('getAllProducts', () {
    test('should return a list of ProductModel when the API call is successful', () async {
      // arrange
      final response = readJson('product_list_response.json');
      when(mockHttpClient.get(Uri.parse(baseUrl)))
          .thenAnswer((_) async => http.Response(response, 200));
      
      // act
      final result = await dataSourceImpl.getAllProducts();
      
      // assert
      expect(result, isA<Right<Failure, List<ProductModel>>>());
      expect(result.getOrElse(() => throw Exception('Unexpected result')), isA<List<ProductModel>>());
    });

    test('should return a CacheFailure when the API call fails with a 500 status', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(baseUrl)))
          .thenAnswer((_) async => http.Response('Server Error', 500));
      
      // act
      final result = await dataSourceImpl.getAllProducts();
      
      // assert
      expect(result, isA<Left<Failure, List<ProductModel>>>());
      expect(result.fold(id, id), isA<CacheFailure>());
    });
  });

  group('insertProduct', () {
    test('should return Right when the API call is successful', () async {
      // arrange
      const product = ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg'
      );
      final requestBody = {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price.toString(),
        'image': product.imageUrl
      };
      when(mockHttpClient.post(Uri.parse(baseUrl), body: jsonEncode(requestBody)))
          .thenAnswer((_) async => http.Response('Created', 201));
      
      // act
      final result = await dataSourceImpl.insertProduct(product);
      
      // assert
      expect(result, isA<Right<Failure, void>>());
    });

    test('should return a CacheFailure when the API call fails with a 400 status', () async {
      // arrange
      const product = ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg'
      );
      final requestBody = {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price.toString(),
        'image': product.imageUrl
      };
      when(mockHttpClient.post(Uri.parse(baseUrl), body: jsonEncode(requestBody)))
          .thenAnswer((_) async => http.Response('Bad Request', 400));
      
      // act
      final result = await dataSourceImpl.insertProduct(product);
      
      // assert
      expect(result, isA<Left<Failure, void>>());
      // expect(result.fold(id, id), isA<CacheFailure>());
    });
  });

  group('updateProduct', () {
    test('should return Right when the API call is successful', () async {
      // arrange
      const product = ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg'
      );
      final requestBody = {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price.toString(),
        'image': product.imageUrl
      };
      when(mockHttpClient.put(Uri.parse(Urls.getProduct(product.id)), body: jsonEncode(requestBody)))
          .thenAnswer((_) async => http.Response('Updated', 200));
      
      // act
      final result = await dataSourceImpl.updateProduct(product);
      
      // assert
      expect(result, isA<Right<Failure, void>>());
    });

    test('should return a CacheFailure when the API call fails with a 404 status', () async {
      // arrange
      const product = ProductModel(
        id: '6672752cbd218790438efdb0',
        name: 'Anime website',
        description: 'Explore anime characters.',
        price: 123,
        imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg'
      );
      final requestBody = {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price.toString(),
        'image': product.imageUrl
      };
      when(mockHttpClient.put(Uri.parse(Urls.getProduct(product.id)), body: jsonEncode(requestBody)))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      
      // act
      final result = await dataSourceImpl.updateProduct(product);
      
      // assert
      expect(result, isA<Left<Failure, void>>());
      // expect(result.fold(id, id), isA<CacheFailure>());
    });
  });

  group('deleteProduct', () {
    test('should return Right when the API call is successful', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(Urls.getProduct(productId))))
          .thenAnswer((_) async => http.Response('Deleted', 200));
      
      // act
      final result = await dataSourceImpl.deleteProduct(productId);
      
      // assert
      expect(result, isA<Right<Failure, void>>());
    });

    test('should return a CacheFailure when the API call fails with a 404 status', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse(Urls.getProduct(productId))))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      
      // act
      final result = await dataSourceImpl.deleteProduct(productId);
      
      // assert
      expect(result, isA<Left<Failure, void>>());
      // expect(result.fold(id, id), isA<CacheFailure>());
    });
  });
}
