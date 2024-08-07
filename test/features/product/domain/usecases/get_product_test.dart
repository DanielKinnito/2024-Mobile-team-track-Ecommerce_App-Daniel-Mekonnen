import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';
import 'package:myapp/features/product/domain/usecases/get_product.dart';

import 'insert_product_test.mocks.dart';

void main(){
  late ProductRepository productRepository;
  late GetProduct usecase;

  setUp((){
    productRepository = MockProductRepository();
    usecase = GetProduct(productRepository);
  });

  late Product product = const Product(
    id: '1',
    category: 'Men\'s Shoes',
    imageUrl: 'assets/images/leather_shoe_1.jpg',
    name: 'Leather Shoe',
    description: 'lorem posum',
    price: 100.0,
    sizes: [39, 40, 41],
  );

  test('should get product from the repository', () async{
    // arrange
    when(productRepository.getProduct(product.id)).thenAnswer((_) async => Right(product));
    // act
    final result = await usecase(product.id);
    // assert
    expect(result, product);
  });
}