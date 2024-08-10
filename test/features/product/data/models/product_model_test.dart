import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

void main() {
  // create a test instance of ProductModel
  var testProductModel = const ProductModel(
    id: 'id',
    name: 'name',
    description: 'description',
    price: 200.0,
    imageUrl: 'imageUrl',
  );

  // test instance of ProductModel
  final testJson = {
    'id': 'id',
    'name': 'name',
    'description': 'description',
    'price': 200.0,
    'imageUrl': 'imageUrl',
  };

  group('ProductModel', () {
    test('should be a subclass of product entity', () async {
      // assert
      expect(testProductModel, isA<Product>());
    });

    test('should correctly convert to json', () async {
      // assert
      final result = testProductModel.toJson();
      expect(result, testJson);
    });

    test('should correctly convert from json', () async {
      // assert
      final Map<String, dynamic> jsonMap = testJson;
      final result = ProductModel.fromJson(jsonMap);
      expect(result, testProductModel);
    });
  });
}
