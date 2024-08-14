import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/insert_product.dart';

import '../../helpers/mocks.mocks.dart';


void main() {
  late InsertProduct usecase;
  late ProductRepository productRepository;

  setUp(() {
    productRepository = MockProductRepository();
    usecase = InsertProduct(productRepository);
  });

  const product = Product(
    id: '1',
    imageUrl: 'assets/images/leather_shoe_1.jpg',
    name: 'Leather Shoe',
    description: 'lorem posum',
    price: 100.0,
  );

  test(
    'should insert a product into the repository',
    () async {
      // arrange
      when(productRepository.insertProduct(product)).thenAnswer((_) async => const Right(product));
      // act
      final result = await usecase(product);
      // assert
      expect(result, equals(const Right(product)));
      verify(productRepository.insertProduct(product));
      verifyNoMoreInteractions(productRepository);
    },
  );

  test(
    'should return a failure when insertion fails',
    () async {
      // arrange
      when(productRepository.insertProduct(product)).thenAnswer((_) async => const Left(DatabaseFailure('Insertion failed')));
      // act
      final result = await usecase(product);
      // assert
      expect(result, equals(const Left(DatabaseFailure('Insertion failed'))));
      verify(productRepository.insertProduct(product)).called(1);
      verifyNoMoreInteractions(productRepository);
    },
  );
}
