import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/user/data/repositories/user_repository_impl.dart';

import '../../helpers/user_mocks.mocks.dart';

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('UserRepositoryImpl', () {
    group('loginUser', () {
      const email = 'test@example.com';
      const password = 'password';
      const token = 'dummyAccessToken';

      test(
          'should return token when the network is connected and remote data source returns token',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.loginUser(email, password))
            .thenAnswer((_) async => token);

        // Act
        final result = await repository.loginUser(email, password);

        // Assert
        expect(result, equals(const Right(token)));
      });

      test(
          'should return ServerFailure when the network is connected but remote data source throws ServerException',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.loginUser(email, password))
            .thenThrow(ServerException());

        // Act
        final result = await repository.loginUser(email, password);

        // Assert
        expect(result, equals(const Left(ServerFailure('Failed to login'))));
      });

      test(
          'should return ConnectionFailure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // Act
        final result = await repository.loginUser(email, password);

        // Assert
        expect(result,
            equals(const Left(ConnectionFailure('No internet connection'))));
      });
    });

    group('registerUser', () {
      const email = 'test@example.com';
      const password = 'password';
      const name = 'Test User';
      const userId = 'userId123';

      test(
          'should return user ID when the network is connected and remote data source returns user ID',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.registerUser(email, password, name))
            .thenAnswer((_) async => userId);

        // Act
        final result = await repository.registerUser(email, password, name);

        // Assert
        expect(result, equals(const Right(userId)));
      });

      test(
          'should return ServerFailure when the network is connected but remote data source throws ServerException',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.registerUser(email, password, name))
            .thenThrow(ServerException());

        // Act
        final result = await repository.registerUser(email, password, name);

        // Assert
        expect(
            result,
            equals(
                const Left(ServerFailure('Failed to register in repo impl'))));
      });

      test('should return ServerFailure when an unexpected error occurs',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.registerUser(email, password, name))
            .thenThrow(Exception('Unexpected error'));

        // Act
        final result = await repository.registerUser(email, password, name);

        // Assert
        expect(result,
            equals(const Left(ServerFailure('Unexpected error occurred'))));
      });

      test(
          'should return ConnectionFailure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // Act
        final result = await repository.registerUser(email, password, name);

        // Assert
        expect(result,
            equals(const Left(ConnectionFailure('No internet connection'))));
      });
    });

    group('fetchAndSaveUserName', () {
      test('should handle errors when fetching user name fails', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.fetchUserName())
            .thenThrow(Exception('Failed to fetch'));

        // Act
        await repository.fetchAndSaveUserName();

        // Assert
        verify(mockRemoteDataSource.fetchUserName()).called(1);
      });
    });
  });
}
