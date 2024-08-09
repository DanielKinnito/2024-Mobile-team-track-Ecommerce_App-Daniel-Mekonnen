import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/data/repositories/product_repository_impl.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  late MockProductRemoteDataSource mockRemoteDataSource;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository =
        ProductRepositoryImpl(productRemoteDataSource: mockRemoteDataSource);
  });

  const prodcutId = '6672752cbd218790438efdb0';
  const product = Product(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg');
  final productModel = ProductModel.fromDomain(product);
  final productList = [product];
  final productModelList = [productModel];

  group('deleteProduct', () {
    test('should return Right when delete is successful', () async {
      // Arrange
      when(mockRemoteDataSource.deleteProduct(prodcutId))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.deleteProduct(prodcutId);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.deleteProduct(prodcutId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when delete fails', () async {
      // Arrange
      when(mockRemoteDataSource.deleteProduct(prodcutId)).thenAnswer(
          (_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.deleteProduct(prodcutId);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.deleteProduct(prodcutId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('geproduct', () {
    test('should return a Product when get is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getProduct(prodcutId))
          .thenAnswer((_) async => Right(productModel));
      // Act
      final result = await repository.getProduct(prodcutId);
      // Assert
      expect(result, const Right(product));
      verify(mockRemoteDataSource.getProduct(prodcutId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when get fails', () async {
      // Arrange
      when(mockRemoteDataSource.getProduct(prodcutId)).thenAnswer(
          (_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.getProduct(prodcutId);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.getProduct(prodcutId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('inserproduct', () {
    test('should return Right when insert is successful', () async {
      // Arrange
      when(mockRemoteDataSource.insertProduct(productModel))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.insertProduct(product);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.insertProduct(productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when insert fails', () async {
      // Arrange
      when(mockRemoteDataSource.insertProduct(productModel)).thenAnswer(
          (_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.insertProduct(product);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.insertProduct(productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('updateProduct', () {
    test('should return Right when update is successful', () async {
      // Arrange
      when(mockRemoteDataSource.updateProduct(productModel))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.updateProduct(product);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.updateProduct(productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when update fails', () async {
      // Arrange
      when(mockRemoteDataSource.updateProduct(productModel)).thenAnswer(
          (_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.updateProduct(product);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.updateProduct(productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getAllProducts', () {
    test('should return a list of Products when getAll is successful',
        () async {
      // Arrange
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Right(productModelList));
      // Act
      final result = await repository.getAllProducts();
      // Assert
      expect(result, Right(productList));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when getAll fails', () async {
      // Arrange
      when(mockRemoteDataSource.getAllProducts()).thenAnswer(
          (_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.getAllProducts();
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
