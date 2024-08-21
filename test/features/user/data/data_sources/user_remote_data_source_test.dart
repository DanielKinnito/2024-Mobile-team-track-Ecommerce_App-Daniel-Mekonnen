import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:myapp/core/constants/constants.dart';
import 'package:myapp/core/exception/exception.dart';
import 'package:myapp/features/user/data/datasources/user_remote_data_source.dart';

import '../../helpers/user_mocks.mocks.dart';

void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('UserRemoteDataSourceImpl', () {
    group('loginUser', () {
      const email = 'test@example.com';
      const password = 'password';
      const accessToken = 'dummyAccessToken';

      test('should return access token when the response is 201', () async {
        // Arrange
        final response = json.encode({
          'data': {'access_token': accessToken}
        });
        when(mockHttpClient.post(
          Uri.parse(UserUrls.loginUser()),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(response, 201));

        // Act
        final result = await dataSource.loginUser(email, password);

        // Assert
        expect(result, equals(accessToken));
      });

      test('should throw ServerException when the response is not 201',
          () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse(UserUrls.loginUser()),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Error', 500));

        // Act
        final call = dataSource.loginUser;

        // Assert
        expect(() => call(email, password), throwsA(isA<ServerException>()));
      });
    });

    group('registerUser', () {
      const email = 'test@example.com';
      const password = 'password';
      const name = 'Test User';
      const userId = 'userId123';

      test('should return user ID when the response is 201', () async {
        // Arrange
        final response = json.encode({
          'data': {'id': userId}
        });
        when(mockHttpClient.post(
          Uri.parse(UserUrls.registerUser()),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(response, 201));

        // Act
        final result = await dataSource.registerUser(email, password, name);

        // Assert
        expect(result, equals(userId));
      });

      test('should throw ServerException when the response is not 201',
          () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse(UserUrls.registerUser()),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Error', 500));

        // Act
        final call = dataSource.registerUser;

        // Assert
        expect(
            () => call(email, password, name), throwsA(isA<ServerException>()));
      });

      test('should throw ServerException when the response data is invalid',
          () async {
        // Arrange
        final response = json.encode({'data': {}});
        when(mockHttpClient.post(
          Uri.parse(UserUrls.registerUser()),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(response, 201));

        // Act
        final call = dataSource.registerUser;

        // Assert
        expect(
            () => call(email, password, name), throwsA(isA<ServerException>()));
      });
    });

    group('fetchUserName', () {
      const userName = 'Mr. User';

      test('should return user name when the response is 200', () async {
        // Arrange
        final response = json.encode({
          'statusCode': 200,
          'message': '',
          'data': {'name': userName}
        });
        when(mockHttpClient.get(Uri.parse(
                'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me')))
            .thenAnswer((_) async => http.Response(response, 200));

        // Act
        final result = await dataSource.fetchUserName();

        // Assert
        expect(result, equals(userName));
      });

      test('should throw Exception when the response is not 200', () async {
        // Arrange
        when(mockHttpClient.get(Uri.parse(
                'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me')))
            .thenAnswer((_) async => http.Response('Error', 500));

        // Act
        final call = dataSource.fetchUserName;

        // Assert
        expect(() => call(), throwsA(isA<Exception>()));
      });
    });
  });
}
