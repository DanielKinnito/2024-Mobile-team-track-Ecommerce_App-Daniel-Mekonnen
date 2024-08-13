import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/delete_product.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late DeleteProduct usecase;
  late ProductRepository productRepository;

  setUp(() {
    productRepository = MockProductRepository();
    usecase = DeleteProduct(productRepository);
  });

  const productId = '1';

  test(
    'should delete a product from the repository',
    () async {
      // arrange
      when(productRepository.deleteProduct(productId)).thenAnswer((_) async => const Right('Product deleted successfully'));
      // act
      final result = await usecase(productId);
      // assert
      expect(result, equals(const Right('Product deleted successfully')));
      verify(productRepository.deleteProduct(productId));
      verifyNoMoreInteractions(productRepository);
    },
  );

  test(
    'should return a failure when the product is not found',
    () async {
      // arrange
      when(productRepository.deleteProduct(productId)).thenAnswer((_) async => const Left(DatabaseFailure('Product not found')));
      // act
      final result = await usecase(productId);
      // assert
      expect(result, equals(const Left(DatabaseFailure('Product not found'))));
      verify(productRepository.deleteProduct(productId)).called(1);
      verifyNoMoreInteractions(productRepository);
    },
  );
}
