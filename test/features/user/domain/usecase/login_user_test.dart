import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/params/params.dart';
import 'package:myapp/features/user/domain/entities/user.dart';
import 'package:myapp/features/user/domain/repositories/user_repository.dart';
import 'package:myapp/features/user/domain/usecase/login_user.dart';

import '../../helpers/user_mocks.mocks.dart';

void main() {
  late LoginUser usecase;
  late UserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = LoginUser(mockUserRepository);
  });

  var user = const User(email: 'email', password: 'password');
  String accessToken = 'granted';
  LoginParams params = LoginParams(email: user.email, password: user.password);

  group('Login User', () {
    test('should login a user successfully', () async {
      // Arrange
      when(mockUserRepository.loginUser(params.email, params.password))
          .thenAnswer((_) async => Right(accessToken));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(Right(accessToken)));
      verify(mockUserRepository.loginUser(params.email, params.password));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return failure when login fails', () async {
      // Arrange
      const failure = ServerFailure('Login failed');
      when(mockUserRepository.loginUser(params.email, params.password))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockUserRepository.loginUser(params.email, params.password));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
