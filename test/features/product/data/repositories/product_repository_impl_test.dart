import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/data/repositories/product_repository_impl.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

void main() {
  late MockProductRemoteDataSource mockRemoteDataSource;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(productRemoteDataSource: mockRemoteDataSource);
  });

  const tProductId = '6672776eb905525c145fe0bb';
  const tProduct = Product(
    id: '6672776eb905525c145fe0bb',
    imageUrl: 'https://example.com/image.jpg',
    name: 'Product Name',
    description: 'Product Description',
    price: 123.0,
  );
  final tProductModel = ProductModel.fromDomain(tProduct);
  final tProductList = [tProduct];
  final tProductModelList = [tProductModel];

  group('deleteProduct', () {
    test('should return Right when delete is successful', () async {
      // Arrange
      when(mockRemoteDataSource.deleteProduct(tProductId))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.deleteProduct(tProductId);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.deleteProduct(tProductId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when delete fails', () async {
      // Arrange
      when(mockRemoteDataSource.deleteProduct(tProductId))
          .thenAnswer((_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.deleteProduct(tProductId);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.deleteProduct(tProductId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getProduct', () {
    test('should return a Product when get is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getProduct(tProductId))
          .thenAnswer((_) async => Right(tProductModel));
      // Act
      final result = await repository.getProduct(tProductId);
      // Assert
      expect(result, const Right(tProduct));
      verify(mockRemoteDataSource.getProduct(tProductId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when get fails', () async {
      // Arrange
      when(mockRemoteDataSource.getProduct(tProductId))
          .thenAnswer((_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.getProduct(tProductId);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.getProduct(tProductId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('insertProduct', () {
    test('should return Right when insert is successful', () async {
      // Arrange
      when(mockRemoteDataSource.insertProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.insertProduct(tProduct);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when insert fails', () async {
      // Arrange
      when(mockRemoteDataSource.insertProduct(tProductModel))
          .thenAnswer((_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.insertProduct(tProduct);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('updateProduct', () {
    test('should return Right when update is successful', () async {
      // Arrange
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => const Right(null));
      // Act
      final result = await repository.updateProduct(tProduct);
      // Assert
      expect(result, const Right(null));
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when update fails', () async {
      // Arrange
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.updateProduct(tProduct);
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getAllProducts', () {
    test('should return a list of Products when getAll is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Right(tProductModelList));
      // Act
      final result = await repository.getAllProducts();
      // Assert
      expect(result, Right(tProductList));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when getAll fails', () async {
      // Arrange
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => const Left(ServerFailure('An error has occurred')));
      // Act
      final result = await repository.getAllProducts();
      // Assert
      expect(result, const Left(ServerFailure('An error has occurred')));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
