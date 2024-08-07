import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

void main() {
  var testProductModel = ProductModel(
    id: 'id',
    name: 'name',
    description: 'description',
    price: 200.0,
    imageUrl: 'imageUrl',
  );

  final test_json = {
    'id': 'id',
    'name': 'name',
    'description': 'description',
    'price': 200.0,
    'imageUrl': 'imageUrl',
  };

  test('should be a subclass of product entity', () async {
    // assert
    expect(testProductModel, isA<Product>());
  });

  test('should correctly convert to json', () async {
    // assert
    final result = testProductModel.toJson();
    expect(result, test_json);
  });

  test('should correctly convert from json', () async {
    // assert
    final Map<String, dynamic> jsonMap = test_json;
    final result = ProductModel.fromJson(jsonMap);
    expect(result, testProductModel);
  });
}
