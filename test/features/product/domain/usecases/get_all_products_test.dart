import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/get_all_products.dart';

import 'insert_product_test.mocks.dart';

void main() {
  late ProductRepository productRepository;
  late GetAllProducts getAllProducts;

  setUp(() {
    productRepository = MockProductRepository();
    getAllProducts = GetAllProducts(productRepository);
  });

  const productList = [
    Product(
      id: '1',
      category: 'Men\'s Shoes',
      imageUrl: 'assets/images/leather_shoe_1.jpg',
      name: 'Leather Shoe',
      description: 'lorem posum',
      price: 100.0,
      sizes: [39, 40, 41],
    ),
    Product(
      id: '2',
      category: 'Women\'s Shoes',
      imageUrl: 'assets/images/leather_shoe_2.jpg',
      name: 'Leather Shoe',
      description: 'lorem posum',
      price: 100.0,
      sizes: [39, 40, 41],
    ),
  ];

  test('should get all products from the repository', () async {
    // arrange
    when(productRepository.getAllProdcuts()).thenAnswer((_) async => const Right(productList));
    // act
    final result = await getAllProducts();
    // assert
    expect(result, const Right(productList));
    verify(productRepository.getAllProdcuts());
    verifyNoMoreInteractions(productRepository);
  });

}
