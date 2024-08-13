import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

void main() {
  // create a test instance of ProductModel
  const testProductModel= ProductModel(
    id: '6672752cbd218790438efdb0',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123.0,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  );

  // test instance of ProductModel
  final testJson = {
    'id': '6672752cbd218790438efdb0',
    'name': 'Anime website',
    'description': 'Explore anime characters.',
    'price': 123.0,
    'imageUrl': 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  };

  group('ProductModel', () {
    test('should be a subclass of Product entity', () async {
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
