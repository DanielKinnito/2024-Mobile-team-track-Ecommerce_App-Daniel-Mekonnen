import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/not_found.dart';
import 'package:myapp/features/product/data/data_sources/product_api.dart';
import 'package:myapp/features/product/data/repositories/product_repository_impl.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/repositories/product_repository.dart';

import 'product_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductApi>()])
void main() {
  late MockProductApi mockProductApi;
  late ProductRepository productRepository;

  setUp(() {
    mockProductApi = MockProductApi();
    productRepository = ProductRepositoryImpl(mockProductApi);
  });

  group('getProduct', () {
    const product = Product(
      id: 'id',
      description: 'description',
      price: 10,
      name: 'name',
      imageUrl: 'imageUrl',
    );
    test('should return a product when api call is successful', () async {
      // arrange
      when(mockProductApi.getProduct(any))
          .thenAnswer((_) async => const Right(product));

      final result = await productRepository.getProduct(product.id);

      expect(result, const Right(product));
      verify(mockProductApi.getProduct(product.id));
      verifyNoMoreInteractions(mockProductApi);
    });

    test('should return a Not Found Failure when api call fails', () async {
      // arrange
      when(mockProductApi.getProduct(any))
          .thenAnswer((_) async => const Left(NotFound()));
      // act
      final result = await productRepository.getProduct(product.id);
      // assert
      expect(result, const Left(NotFound()));
      verify(productRepository.getProduct(product.id));
      verifyNoMoreInteractions(mockProductApi);
    });
  });

  group('insertProduct', () {
    const product = Product(
      id: 'id',
      description: 'description',
      price: 10,
      name: 'name',
      imageUrl: 'imageUrl',
    );
    test('should add/insert a product when api call is successful', () async {
      // arrange
      when(mockProductApi.insertProduct(any))
          .thenAnswer((_) async => const Right(product));

      final result = await productRepository.insertProduct(product);

      expect(result, const Right(product));
      verify(mockProductApi.insertProduct(product));
      verifyNoMoreInteractions(mockProductApi);
    });
  });
  group('getAllProducts', () {
    const productList = [
      Product(
        id: 'id1',
        description: 'description',
        price: 10,
        name: 'name',
        imageUrl: 'imageUrl',
      ),
      Product(
        id: 'id2',
        description: 'description',
        price: 10,
        name: 'name',
        imageUrl: 'imageUrl',
      ),
      Product(
        id: 'id3',
        description: 'description',
        price: 10,
        name: 'name',
        imageUrl: 'imageUrl',
      ),
    ];
    test('should return a stream of products when api call is successful',
        () async {
      // arrange
      when(mockProductApi.getAllProducts())
          .thenAnswer((_) async => const Right(productList));

      final result = productRepository.getAllProdcuts();

      expect(result, const Right(productList));
      verify(mockProductApi.getAllProducts());
      verifyNoMoreInteractions(mockProductApi);
    });
  });

  group('updateProduct', () {
    const product = Product(
      id: 'id',
      description: 'description',
      price: 10,
      name: 'name',
      imageUrl: 'imageUrl',
    );
    test('should update a product when api call is successful', () async {
      // arrange
      when(mockProductApi.updateProduct(any))
          .thenAnswer((_) async => const Right(product));

      final result = await productRepository.updateProduct(product);

      expect(result, const Right(product));
      verify(mockProductApi.updateProduct(product));
      verifyNoMoreInteractions(mockProductApi);
    });

    test('should return a Not Found Failure when api call fails', () async {
      // arrange
      when(mockProductApi.updateProduct(any))
          .thenAnswer((_) async => const Left(NotFound()));
      // act
      final result = await productRepository.updateProduct(product);
      // assert
      expect(result, const Left(NotFound()));
      verify(productRepository.updateProduct(product));
      verifyNoMoreInteractions(mockProductApi);
    });
  });
  group('deleteProduct', () {
    const product = Product(
      id: 'id',
      description: 'description',
      price: 10,
      name: 'name',
      imageUrl: 'imageUrl',
    );
    test('should delete a product when api call is successful', () async {
      // arrange
      when(mockProductApi.deleteProduct(any))
          .thenAnswer((_) async => const Right(product));

      final result = await productRepository.deleteProduct(product.id);

      expect(result, const Right(product));
      verify(mockProductApi.deleteProduct(product.id));
      verifyNoMoreInteractions(mockProductApi);
    });

    test('should return a Not Found Failure when api call fails', () async {
      // arrange
      when(mockProductApi.deleteProduct(any))
          .thenAnswer((_) async => const Left(NotFound()));
      // act
      final result = await productRepository.deleteProduct(product.id);
      // assert
      expect(result, const Left(NotFound()));
      verify(productRepository.deleteProduct(product.id));
      verifyNoMoreInteractions(mockProductApi);
    });
  });
}
