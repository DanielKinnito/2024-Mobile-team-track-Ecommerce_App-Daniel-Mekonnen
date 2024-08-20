import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LoginUser extends Usecase<Future<Either<Failure, String>>, LoginParams> {
  final UserRepository userRepository;

  LoginUser({required this.userRepository});

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await userRepository.loginUser(params.email, params.password);
  }
}
