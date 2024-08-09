import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main(){
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl dataSourceImpl;
  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  var productModel = const ProductModel(
    id: '66b0b23928f63adda72ab38a',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123.0,
    imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg'
  );

  test('should return product from sharedpreferences', () async {
    //arrange
    final expectedJsonSting =  jsonEncode(productModel.toJson());
    when(mockSharedPreferences.getString(productModel.id)).thenReturn(expectedJsonSting);
    //act
    final result = await dataSourceImpl.getProduct(productModel.id);
    // assert
    verify(mockSharedPreferences.getString(productModel.id));
    expect(result, Right(productModel));
    verifyNoMoreInteractions(mockSharedPreferences);
  });
}