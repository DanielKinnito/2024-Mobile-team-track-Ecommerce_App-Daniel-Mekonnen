import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/network/network_info.dart';
import 'package:myapp/features/product/data/data_sources/product_local_data_source.dart';
import 'package:myapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:myapp/features/product/data/models/product_model.dart';
import 'package:myapp/features/product/data/repositories/product_repository_impl.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

// Ensure your mock classes are imported

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}
class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

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
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tProductModel = ProductModel(
    id: '6672752cbd218790438efdb0',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123,
    imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  );
  const tProduct = Product(
    id: '6672752cbd218790438efdb0',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123,
    imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
  );

  group('getProduct', () {
    test('should return product from local data source when internet is connected', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockLocalDataSource.getCachedProduct(tProduct.id))
          .thenAnswer((_) async => tProductModel);
      // act
      final result = await repository.getProduct(tProduct.id);
      // assert
      expect(result, const Right(tProduct));
      verify(mockLocalDataSource.getCachedProduct(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return product from remote data source when internet is connected', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockLocalDataSource.getCachedProduct(tProduct.id)).thenThrow(CacheException());
      when(mockRemoteDataSource.getProduct(tProduct.id))
          .thenAnswer((_) async => tProductModel);
      // act
      final result = await repository.getProduct(tProduct.id);
      // assert
      expect(result, const Right(tProduct));
      verify(mockRemoteDataSource.getProduct(tProduct.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return server failure when the remote data source fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockLocalDataSource.getCachedProduct(tProduct.id)).thenThrow(CacheException());
      when(mockRemoteDataSource.getProduct(tProduct.id))
          .thenThrow(ServerException());
      // act
      final result = await repository.getProduct(tProduct.id);
      // assert
      expect(result, const Left(ServerFailure('Server error')));
      verify(mockRemoteDataSource.getProduct(tProduct.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return connection failure when there is no internet connection', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getProduct(tProduct.id);
      // assert
      expect(result, const Left(ConnectionFailure('No Internet Connection')));
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });

  group('insertProduct', () {
    test('should return product when the remote data source is successful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(tProductModel)).thenAnswer((_) async => tProductModel);
      // act
      final result = await repository.insertProduct(tProduct);
      // assert
      expect(result, const Right(tProduct));
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when the remote data source fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(tProductModel))
          .thenThrow(ServerException());
      // act
      final result = await repository.insertProduct(tProduct);
      // assert
      expect(result, const Left(ServerFailure('Server error')));
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return connection failure when there is no internet connection', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.insertProduct(tProduct);
      // assert
      expect(result, const Left(ConnectionFailure('No Internet Connection')));
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });

  group('updateProduct', () {
    test('should return product when the remote data source is successful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel)).thenAnswer((_) async => tProductModel);
      // act
      final result = await repository.updateProduct(tProduct);
      // assert
      expect(result, const Right(tProduct));
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when the remote data source fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenThrow(ServerException());
      // act
      final result = await repository.updateProduct(tProduct);
      // assert
      expect(result, const Left(ServerFailure('Server error')));
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return connection failure when there is no internet connection', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.updateProduct(tProduct);
      // assert
      expect(result, const Left(ConnectionFailure('No Internet Connection')));
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });

  group('deleteProduct', () {
    test('should return success message when the remote data source is successful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct(tProduct.id))
          .thenAnswer((_) async => 'Product deleted successfully');
      // act
      final result = await repository.deleteProduct(tProduct.id);
      // assert
      expect(result, const Right('Product deleted successfully'));
      verify(mockRemoteDataSource.deleteProduct(tProduct.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when the remote data source fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct(tProduct.id))
          .thenThrow(ServerException());
      // act
      final result = await repository.deleteProduct(tProduct.id);
      // assert
      expect(result, const Left(ServerFailure('Server error')));
      verify(mockRemoteDataSource.deleteProduct(tProduct.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return connection failure when there is no internet connection', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.deleteProduct(tProduct.id);
      // assert
      expect(result, const Left(ConnectionFailure('No Internet Connection')));
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });
}
