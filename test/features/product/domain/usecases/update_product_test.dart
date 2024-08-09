import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/update_product.dart';

import 'insert_product_test.mocks.dart';

void main(){
  late ProductRepository productRepository;
  late UpdateProduct usecase;

  setUp((){
    productRepository = MockProductRepository();
    usecase = UpdateProduct(productRepository);
  });

  var  product = const Product(
    id: '1',
    description: 'lorem posum',
    imageUrl: 'assets/images/leather_shoe_1.jpg',
    name: 'Leather Shoe',
    price: 100.0,
    sizes: [39, 40, 41],
    category: 'Men\'s Shoes'
  );

  test('Should update product from the repository', () async {
      // arrange
      when(productRepository.updateProduct(product)).thenAnswer((_) async => Right(product));
      // act
      final result = await usecase(product);
      // assert
      expect(result, Right(product));
      verify(productRepository.updateProduct(product)).called(1);
      verifyNoMoreInteractions(productRepository);
  });

    test('should return a Failure when the product is not in the repository', () async {
    // arrange
    when(productRepository.updateProduct(product)).thenAnswer((_) async => const Left(DatabaseFailure('Failed to update product')));
    // act
    final result = await usecase(product);
    // assert
    expect(result, const Left(DatabaseFailure('Failed to update product')));
    verify(productRepository.updateProduct(product)).called(1);
    verifyNoMoreInteractions(productRepository);
  });
  
}