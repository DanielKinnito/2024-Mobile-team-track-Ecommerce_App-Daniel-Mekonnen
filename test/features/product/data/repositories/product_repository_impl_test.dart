import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/network/network_info.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/data/repositories/product_repository_impl.dart';

import '../../helpers/mocks.dart';
import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tProductModels = [
    ProductModel(
      id: '123',
      name: 'Product 1',
      description: 'Description 1',
      price: 100,
      imageUrl: 'https://example.com/image1.jpg',
    ),
    // Add more products as needed
  ];

  const tProducts = tProductModels; // Since both models and entities are the same in this case

  group('getAllProducts', () {
    test('should return Right with a list of products when the call to remote data source is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => tProductModels);

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, equals(Right(tProducts)));
      verify(mockRemoteDataSource.getAllProducts());
      verify(mockLocalDataSource.cacheProducts(tProductModels));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return ServerFailure when the call to remote data source fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts()).thenThrow(ServerException());

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result,
          equals(const Left(ServerFailure('Failed to fetch products from the server.'))));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when there is no network and cache fetch fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastProducts()).thenThrow(CacheException());

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result,
          equals(const Left(CacheFailure('Failed to fetch products from the cache.'))));
      verify(mockLocalDataSource.getLastProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
