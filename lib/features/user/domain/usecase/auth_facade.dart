import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

abstract class AuthFacade {
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, String>> registerUser(
      String email, String password, String name);
}
