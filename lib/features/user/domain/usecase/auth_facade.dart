import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/user.dart';

abstract class AuthFacade {
  Future<Either<Failure, User>> loginUser(String email, String password);
  Future<Either<Failure, User>> registerUser(String email, String password, String name);
}
