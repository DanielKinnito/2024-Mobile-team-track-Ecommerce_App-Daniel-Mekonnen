import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/insert_product.dart';

import 'insert_product_test.mocks.dart';
@GenerateMocks([ProductRepository])
void main(){
  ProductRepository productRepository = MockProductRepository();
  InsertProduct usecase = InsertProduct(productRepository);

  setUp((){
    productRepository = MockProductRepository();
    usecase = InsertProduct(productRepository);
  });

  var product = const Product(
    id: '1',
    imageUrl: 'assets/images/leather_shoe_1.jpg',
    name: 'Leather Shoe',
    description: 'lorem posum',
    price: 100.0,
  );
  
  test('should add/insert a product from the repository', () async {
    // arrange
    // ignore: void_checks
    when(productRepository.insertProduct(product)).thenAnswer((_) async => Right(product));
    // act
    final result = await usecase(product);
    // assert
    expect(result, Right(product));
    verify(productRepository.insertProduct(product));
    verifyNoMoreInteractions(productRepository);
  });

}
