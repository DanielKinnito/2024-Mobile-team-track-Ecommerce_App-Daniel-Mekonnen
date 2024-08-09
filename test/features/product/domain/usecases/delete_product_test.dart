import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/delete_product.dart';

import 'insert_product_test.mocks.dart';

void main(){
  late DeleteProduct usecase;
  late ProductRepository productRepository;

  setUp((){
    productRepository = MockProductRepository();
    usecase = DeleteProduct(productRepository);
  });

  var product = const Product(
    id: '1',
    category: 'Men\'s Shoes',
    imageUrl: 'assets/images/leather_shoe_1.jpg',
    name: 'Leather Shoe',
    description: 'lorem posum',
    price: 100.0,
    sizes: [39, 40, 41],
  );

  test(
    'should delete a product from the repository',
    () async {
      // arrange
      when(productRepository.deleteProduct(product.id)).thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(product.id);
      // assert
      expect(result, const Right(null));
      verify(productRepository.deleteProduct(product.id));
      verifyNoMoreInteractions(productRepository);
    },
  );
  test(
    'should return a failure when the product is not found',
    () async {
      // arrange
      when(productRepository.deleteProduct(product.id)).thenAnswer((_) async => const Left(DatabaseFailure('Product not found')));
      // act
      final result = await usecase(product.id);
      // assert
      expect(result, const Left(DatabaseFailure('Product not found')));
      verify(productRepository.deleteProduct(product.id)).called(1);
      verifyNoMoreInteractions(productRepository);
    },
  );

}