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

  // Adjust the test JSON to ensure it's treated as a list of maps
  final tProductListJson = jsonEncode(
    tProductList.map<Map<String, dynamic>>((product) => product.toJson()).toList(),
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
}