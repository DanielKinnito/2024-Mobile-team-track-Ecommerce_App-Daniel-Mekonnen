import 'package:dartz/dartz.dart';

import '../../../../core/exception/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.loginUser(email, password);
        return Right(token);
      } on ServerException {
        return const Left(ServerFailure('Failed to login'));
      }
    } else {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> registerUser(
      String email, String password, String name) async {
    if (await networkInfo.isConnected) {
      try {
        final id = await remoteDataSource.registerUser(email, password, name);
        return Right(id);
      } on ServerException {
        print('ServerException in registerUser');
        return const Left(ServerFailure('Failed to register in repo impl'));
      } catch (e) {
        print('Unexpected error: $e');
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    } else {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }
}
