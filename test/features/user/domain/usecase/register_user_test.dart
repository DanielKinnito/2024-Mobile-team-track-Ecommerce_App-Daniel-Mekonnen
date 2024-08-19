import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/params/params.dart';
import 'package:myapp/features/user/domain/entities/user.dart';
import 'package:myapp/features/user/domain/usecase/register_user.dart';

import '../../helpers/user_mocks.mocks.dart';

void main() {
  late RegisterUser usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = RegisterUser(mockUserRepository);
  });

  var user =
      User(email: 'email@example.com', password: 'password', name: 'John Doe');
  RegisterParams params = RegisterParams(
    email: user.email,
    password: user.password,
    name: user.name ?? '',
  );

  group('Register User', () {
    test('should register a user successfully', () async {
      // Arrange
      when(mockUserRepository.registerUser(
              params.email, params.password, params.name))
          .thenAnswer((_) async => Right(user));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(Right(user)));
      verify(mockUserRepository.registerUser(
          params.email, params.password, params.name));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return failure when registration fails', () async {
      // Arrange
      const failure = ServerFailure('Registration failed');
      when(mockUserRepository.registerUser(
              params.email, params.password, params.name))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockUserRepository.registerUser(
          params.email, params.password, params.name));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
